---
layout: layouts/post.njk
title: Emacs Lisp Functions for Easy BibTeX Recording
date: 2022-07-09
tags: post
---

# Emacs Lisp Functions for Easy BibTeX Recording

Here's an Emacs Lisp function for getting a BibTeX entry from a URL (like those URLs you get when clicking "cite" and copying the "BibTeX" link on a Google Scholar search result):

```emacs-lisp
(defun get-bibtex-from-url (url)
  "Get a BibTeX entry from URL and store it in my `references.bib'."
  (interactive "MBibTeX URL: ")
  (write-bibtex-entry (get-bibtex-url-contents url)))
```

It's very simple: `interactive` allows the user to enter a URL, `get-bibtex-url-contents` fetches the contents of that URL and `write-bibtex-entry` appends the contents to my `references.bib` file.

Now a somewhat less simple function. This one takes a [Digital Object Identifier](https://en.wikipedia.org/wiki/Digital_object_identifier) (DOI), fetches the corresponding BibTeX entry from the [Crossref](https://www.crossref.org/) API and, again, appends the entry to `references.bib`. (I adapted this from [Pavel Iosad's original](https://www.anghyflawn.net/blog/2014/emacs-give-a-doi-get-a-bibtex-entry/).) The returned entry contains the DOI (as a full URL) with an ASCII-encoded slash – the `%2F` there – so the function also replaces that with a decoded slash.

```emacs-lisp
(defun get-bibtex-from-doi (doi)
  "Get a BibTeX entry from the DOI and store it in my `references.bib'."
  (interactive "MDOI: ")
  (let* ((url-mime-accept-string "text/bibliography;style=bibtex")
         (base-url
          "https://api.crossref.org/works/%s/transform/application/x-bibtex")
         (doi-resource (s-replace "http://dx.doi.org/" "" doi))
         (url (format base-url doi-resource))
         (response-body (get-bibtex-url-contents url))
         (bibtex-entry (s-replace "%2F" "/" response-body)))
    (write-bibtex-entry bibtex-entry)))
```

Okay, how do `get-bibtex-url-contents` and `write-bibtex-entry` work? Let's look at the first one first. The `with-temp-buffer` macro takes one or more functions, creates a temporary buffer and evaluates the functions as if the temporary buffer were the current buffer. The `url-insert-file-contents` function takes a URL, calls it and puts the response body in a buffer, which it returns. So now `get-bibtex-url-contents` has the response body in the current (temporary) buffer. It then takes the value of that buffer (using `buffer-string`) and stores it in the `result` variable, which it returns.

```emacs-lisp
(defun get-bibtex-url-contents (url)
  "Fetch the contents of URL and return the result as a string."
  (with-temp-buffer
    (url-insert-file-contents url)
    (setq result (buffer-string)))
  result)
```

The `write-bibtex-entry` function takes a BibTeX entry (as a string) and adds it to the end of a `references.bib` file. It too uses the `with-temp-buffer` macro to create a temporary buffer, into which it pastes the current contents of the `references.bib` file. It goes to the end of the file using `goto-char` and `point-max` and inserts the BibTeX entry there. Then it goes to the beginning of the newly inserted entry (BibTeX entries begin with @) and cleans and formats the entry. Finally, it takes the whole content of the temporary buffer and writes it to `references.bib`. Done! (It also refreshes the [Citar](https://github.com/emacs-citar/citar) cache so that I can immediately find the new entry when inserting citations; this step can be replaced or removed if you're using [helm-bibtex/ivy-bibtex](https://github.com/tmalsburg/helm-bibtex) or some other alternative to Citar.)

```emacs-lisp
(defun write-bibtex-entry (bibtex-entry)
  "Write BIBTEX-ENTRY (a string) to my `references.bib' file."
  (let ((reference-filepath "/path/to/references.bib"))
    (with-temp-buffer
      (insert-file-contents reference-filepath)
      (goto-char (point-max))
      (insert "\n" (s-trim bibtex-entry) "\n")
      (search-backward "@")
      (bibtex-fill-entry)
      (bibtex-clean-entry)
      (write-region (point-min) (point-max) reference-filepath))
    (citar-refresh)))
```

I wrote these functions because, having started using Emacs to manage my references back in February (you might've noticed the new References section at the end of [some]({{ '/posts/doubts-about-track-record-arguments-for-utilitarianism/#references' | url }}) [posts]({{ '/posts/nuclear-decay/#references' | url }})), I wanted to reduce the friction of adding a paper or book to my bibliography. That's the blessing and the curse of Emacs: you get endless extensibility, but you also get endless extensibility. It's kind of a trap, which is why I don't recommend it for other people. But it's also fun, and powerful.

Will this save me time in the long run? I've added 116 citations to my `references.bib` so far; over a period of five months that makes roughly 0.77 citations per day. Suppose it would take me ten seconds to find the reference, copy the BibTeX entry, open up `references.bib`, paste the entry and refresh Citar without these functions. Suppose it does take me three seconds to do the same with these functions. Suppose I spent roughly three hours implementing these functions (they were passable pretty early on but I spent some time fixing a bug). To make up my deficit I need to add 3 × 60 × 60 ÷ (10 - 3) = 1,543 entries. At the current rate, that will take me only 1,543 ÷ 0.77 = 2,004 days or five and a half years!

There are some more advantages in doing this sort of thing:

- It's satisfying!
- It makes me excited about doing stuff like collecting and citing references.
- It teaches me more Emacs Lisp, which I can use to more skilfully lose time in future.
- It gives me something to write blog posts about.
