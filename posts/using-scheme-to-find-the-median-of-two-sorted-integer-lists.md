---
layout: layouts/post.njk
title: Using Scheme to Find the Median of Two Sorted Integer Lists
date: 2021-06-05
tags: post
---

# Using Scheme to Find the Median of Two Sorted Integer Lists

I have been picking up the basics of Scheme recently as part of reading and working my way through Chris Hanson and Gerald Jay Sussman's _Software Design for Flexibility_. Scheme is a dialect of Lisp created in the 1970s by Gerald Jay Sussman and Guy L. Steele. As such, it is older than some other well-known dialects like Common Lisp, Clojure and Racket, all of which have been influenced by Scheme. Specifically, I am using [MIT/GNU Scheme](https://www.gnu.org/software/mit-scheme/) – there are apparently pretty large differences between implementations due to the minimalism of the language specification.

I don't have much experience with Lisps, apart from some noodling with Clojure in our functional programming group at work years ago. So a few months ago, in order to get familiar with the syntax and some of the more basic constructs (leaving the metaprogramming and so on for later), I solved a few problems from LeetCode, one of which was [Median of Two Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/), which I will now proceed to explain.

The problem is this: given two sorted integer lists, calculate the median value of the combination of the two lists, ideally in _O_(log(m+n)) time. For example:

```scheme
1 ]=> (median '(1 3) '(2))
;Value: 2

1 ]=> (median '(1 2) '(3 4))
;Value: 5/2
```

Let us start by implementing a kind of naïve, slow version. Getting the median of a single sorted list is trivial: it is either the central value if the list has an odd-numbered length, or the mean of the two central values otherwise. So the naïve approach is to combine the two lists, sort the combined list and get the median from the combined and sorted list. An implementation could look something like this:

```scheme
;; Returns the median value of two sorted integer lists.
(define (slow-median l1 l2)
  (let ((l (sort (append l1 l2) <)))
  (if (= (modulo (length l) 2) 0)
      (/ (+ (list-ref l (integer-floor (- (length l) 1) 2))
            (list-ref l (integer-ceiling (- (length l) 1) 2)))
         2)
      (list-ref l (integer-floor (length l) 2)))))
```

The procedure begins by merging the two lists (`append`) and sorting the new list in ascending order (`sort ... <`). Then it checks whether the combined list has an even-numbered length. If so, it gets the two central values and returns their mean. If not, it returns the single central value. (`list-ref` here returns the list element at a given index; `integer-floor` is integer division rounded down; `integer-ceiling` is integer division rounded up.)

```scheme
1 ]=> (slow-median '(1 3) '(2))
;Value: 2

1 ]=> (slow-median '(1 2) '(3 4))
;Value: 5/2
```

The more efficient algorithm for solving this problem is basically a more complicated variant of [binary search](https://en.wikipedia.org/wiki/Binary_search_algorithm). It is more complicated than the common binary search both because it is searching two lists simultaneously and because the search in each list depends on the values of the other list.

The highlighted answer on LeetCode is pretty abstruse. (There is a better explanation [here](https://medium.com/@hazemu/finding-the-median-of-2-sorted-arrays-in-logarithmic-time-1d3f2ecbeb46).) The gist of it is that we can rephrase the problem to one not of finding the median of two sorted lists, but of finding how many elements each of the two lists have that are the median or are below the median. So for example in `(1,3,5) (2,4)` the first list contributes two values (one and three) and the second list contributes one (two), since the median is three. If we have these two sublists, calculating the median is trivial.

So the algorithm will solve that problem first. The way to solve that problem is to recursively divide both lists in half. If the last element of the first half of each list is smaller than the first element of the opposite list's second half, then we are good to go – the two first halves are the values up to and including the median. If, on the other hand, the last element of the first half of one list is larger than the first element of the second half of the other list, then we know that the first half of the other list is below the median, but we still need to do this same comparison between the first half of the first list and the second half of the other list in order to find the rest of the elements below the median.

I know that all sounds a little bit complicated. Here is an example:

1. Take the input `(1,4,7,8,9)` and `(2,3,4,5,6)`.
2. Split the two lists in half: `(1,4,7) (8,9)` and `(2,3,4) (5,6)`
3. Now we see that the last value of the first half of the first list is larger than the first value of the second half of the second list: 7 \> 5. That means that the first half of the second list, `(2,3,4)`, is below the median, but we still don't know which of the elements in the first half of the first list and the second half of the second list are. So we return `() (2,3,4)` (because the second list contributed three elements) plus the result of calling the procedure recursively with those two lists, `(1,4,7)` and `(5,6)`.
4. Split the two new lists in half: `(1,4) (7)` and `(5) (6)`.
5. Neither list has a first half whose last element is larger than the first element of the other list's second half, in other words 4 ≤ 6 and 5 ≤ 7, so we are good to go here and return `(1,4) (5)` (because the first list contributed two elements and the second list one).
6. In total, the algorithm returns `() (2,3,4) ++ (1,4) (5) = (1,4) (2,3,4,5)`, giving us a median of `(4 + 5) / 2 = 4.5`.

I hope that makes some kind of sense. The actual algorithm is a little bit more complicated, because it needs to track the precise number of elements that remain to make up the desired number, the number of elements smaller than and including the median (six in the example above, because the two lists had ten elements in total, and when the total is even, we need both central values). This seems necessary because the algorithm can't always round up or always round down when splitting the lists – it depends on the context. So that is actually fed into the recursive procedure at each step in addition to the two lists. I call this value `desired-n` inside the procedure. Maybe there is a way to make the algorithm work without this addition, but I could not find it.

One more thing. I have been calling the procedure's inputs _lists_, but in fact this second implementation will use not lists but vectors. That is because we will be doing a lot of accessing by index, which should be _O_(1) for vectors but _O_(n) for lists (at least I am assuming that is the case; the MIT/GNU Scheme reference manual doesn't seem to say).

Before turning our eyes to the actual implementation we will need to write some utility procedures. Amazingly, as far as I can tell, there is no procedure in MIT/GNU Scheme for checking whether a vector is empty or not (though there is one, `null?`, for lists). So let us begin with that one:

```scheme
;; Returns :t if the vector is empty; otherwise returns :f.
(define (vector-null? v) (= 0 (vector-length v)))
```

What's more, though there is a procedure for getting the first (or the eighth!) element of a vector, there is no procedure for getting the last element of a vector. This is straightforward:

```scheme
;; Returns the last element of the vector.
(define (vector-last v) (vector-ref v (- (vector-length v) 1)))
```

Finally, we will implement a procedure for doing a pairwise concatenation of two pairs of vectors. That is, we concatenate the first elements of both pairs, then concatenate the second elements of both pairs and return a pair with the two concatenations. `cons` here is a procedure for creating a new pair; `car` gets the first element in a pair; `cdr` gets the second element.[^1]

```scheme
;; Returns the pairwise concatenations of two pairs of vectors.
(define (++ p1 p2) (cons (vector-append (car p1) (car p2))
                         (vector-append (cdr p1) (cdr p2))))
```

We can then test these:

```scheme
1 ]=> (vector-null? #())
;Value: #t

1 ]=> (vector-null? #(3 1 4))
;Value: #f

1 ]=> (vector-last #(3 1 4))
;Value: 4

1 ]=> (++ (cons #(1 2) #(3 4)) (cons #(5 6) #(7 8)))
;Value: (#(1 2 5 6) . #(3 4 7 8))
```

Here is what you've been waiting for, the full algorithm:

```scheme
;; Returns the median value of two sorted integer lists.
(define (fast-median vector1 vector2)
  (assert (> (+ (vector-length vector1) (vector-length vector2))
             0))
  ;; This procedure takes two vectors `v1' and `v2' and an
  ;; integer `desired-n' and determines how the `desired-n'
  ;; number of smallest values are distributed between the two
  ;; vectors. It returns a pair of vectors, the values in each
  ;; vector respectively that make up the list of the
  ;; `desired-n' smallest values.
  ;;
  ;; Example:
  ;;
  ;;    (lp #(1 3) #(4 5 6) 3) => (#(1 3) . #(4))
  (define (lp v1 v2 desired-n)
    (let* ((split1 (cond ((vector-null? v1) 0)
                         ((vector-null? v2) desired-n)
                         (else (integer-floor
                                (+ (vector-length v1) 1) 2))))
           (split2 (- desired-n split1))
           (head1 (vector-head v1 split1))
           (tail1 (vector-tail v1 split1))
           (head2 (vector-head v2 split2))
           (tail2 (vector-tail v2 split2)))
      (cond ((vector-null? head1) (cons #() head2))
            ((vector-null? head2) (cons head1 #()))
            ((and (not (vector-null? tail2))
                  (> (vector-last head1) (vector-first tail2)))
             (++ (cons #() head2)
                 (lp head1
                     tail2
                     (- desired-n (vector-length head2)))))
            ((and (not (vector-null? tail1))
                  (> (vector-last head2) (vector-first tail1)))
             (++ (cons head1 #())
                 (lp tail1
                     head2
                     (- desired-n (vector-length head1)))))
            (else (cons head1 head2)))))
  (let* ((median-idx (lambda (n) (if (= n 0)
                                0
                                (+ (integer-floor n 2) 1))))
         (combined-length (+ (vector-length vector1)
                             (vector-length vector2)))
         (desired-n (median-idx combined-length))
         (nums-left-of-median (lp vector1 vector2 desired-n))
         (combined-length-is-even (= (modulo combined-length 2)
                                     0))
         (last-two (lambda (v) (vector-tail
                           v (max 0 (- (vector-length v) 2)))))
         (highest-nums (vector-append
                        (last-two (car nums-left-of-median))
                        (last-two (cdr nums-left-of-median))))
         (sorted (sort! highest-nums <))
         (highest-two (last-two sorted))
         (median (if combined-length-is-even
                     (/ (+ (vector-first highest-two)
                           (vector-last highest-two)) 2)
                     (vector-last highest-two))))
    median))
```

And we can test it:

```scheme
1 ]=> (fast-median #(1 3) #(2))
;Value: 2

1 ]=> (fast-median #(1 2) #(3 4))
;Value: 5/2

1 ]=> (fast-median #(1 4 7 8 9) #(2 3 4 5 6))
;Value: 9/2
```

This procedure is a lot faster than the previous one. I haven't figured out a nice way of benchmarking procedures in Scheme, but running them for large lists, `slow-median` takes several seconds to compute, whereas `fast-median` is instantaneous:

```scheme
1 ]=> (define l1 (iota 1000000 1)) ; iota creates a sequence
;Value: l1

1 ]=> (define l2 (iota 1500000 10000))
;Value: l2

1 ]=> (slow-median l1 l2) ; takes a couple of seconds
;Value: 630000

1 ]=> (define v1 (list->vector l1))
;Value: v1

1 ]=> (define v2 (list->vector l2))
;Value: v2

1 ]=> (fast-median v1 v2) ; instantaneous
;Value: 630000
```

The procedure is made up of 37 lines in total, comments and utility procedures excluded.[^2] The [highlighted Java and Python solutions](https://leetcode.com/problems/median-of-two-sorted-arrays/solution/) at LeetCode are made up of 34 and 24 lines of code respectively. These versions are probably nicer than the one I wrote. It all seems somewhat easier in imperative code, given that the algorithm is both looking at subsets of the two provided lists and constantly comparing to elements outside those subsets. This makes it easier to work with indices rather than actually splitting up the lists, as is more natural in functional programming. But I don't leave out the possibility that there is a Scheme procedure out there far more beautiful and just as fast as the one that I have come up with.

[^1]: These confusing names are historical baggage. `car` is short for _contents of the address part of register_ and `cdr` _contents of the decrement part of register_. I assume `cons` is short for _construct_ or something like that. See Hanson & Sussman, _Software Design for Flexibility_, Appendix B.
[^2]: Actually, the code presented here is made up of more lines because I had to compress it horizontally in order to fit on the desktop version of the website.
