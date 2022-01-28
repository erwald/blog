---
layout: layouts/post.njk
title: How I Track My Hour Balance with a Custom org-mode Clock Table
date: 2022-01-22
tags: post
---

# How I Track My Hour Balance with a Custom org-mode Clock Table

No one at my work actually cares how many hours I work; they just care that I get a certain amount of work done each day or week or month. But for the sake of my own sanity, I still track the number of hours I work each day. That might surprise you, if you associate time clocking with cost-cutting management and employee surveillance. But of course I don't share my numbers with anyone else. This way, if I've worked shorter days, I know I have some catching up to do, and if I've had a busy period, I can compensate in the days ahead. I don't need to worry about whether I'm not working enough or working too much or anything like that.

(Many years ago, when I worked my first job – a ten-month stint building prototypes at Volvo Cars – management extended the physical time clock mandate to white-collar employees, who had previously been able to report their hours at their convenience via a web tool. I remember several colleagues later on saying something to the effect that they had gained many extra hours this way, though perhaps they were the conscientious ones.)

Emacs's org-mode can do lots of things, and one of them is clock hours. However, it doesn't provide an out-of-the-box method for calculating hour balance. By hour balance, I mean how many hours one has worked over or under what one has decided one _should have_ worked. Say I'm supposed to work eight hours per day but have actually worked these hours:

```lisp
:LOGBOOK:
CLOCK: [2022-01-10 Mon 10:30]--[2022-01-10 Mon 20:00] =>  9:30
CLOCK: [2022-01-11 Tue 12:00]--[2022-01-11 Tue 19:00] =>  7:00
CLOCK: [2022-01-12 Wen 11:30]--[2022-01-12 Wen 20:00] =>  8:30
CLOCK: [2022-01-13 Thu 12:00]--[2022-01-13 Thu 20:00] =>  8:00
:END:
```

(Assume that I don't eat lunch, or that I eat lunch at my desk.) According to this log, I have worked 9.5 + 7 + 8.5 + 8 - 4 \* 8 = 1 hour extra. That's a simple calculation, but when you reach hundreds of days, it gets more difficult. So it is a good thing that we know how to program and can create our own custom org-mode clock table. Here's what I came up with:

```lisp
(require 'cl-lib)
(require 'org-clock)
(defun org-dblock-write:work-report (params)
  "Calculate how many hours too many or too few I have worked.
PARAMS are defined in the template, they are :tstart for the
first day for which there's data (e.g. <2022-01-01>) and :tend
for the last date (e.g. <now>)."
  ;; cl-flet is a macro from the common lisp emulation package
  ;; that allows us to bind functions, just like let allows us to
  ;; do with values.
  (cl-flet*
      ((format-time (time) (format-time-string
                            (org-time-stamp-format t t) time))
       (get-minutes-from-log (t1 t2) (cl-second
                           (org-clock-get-table-data
                            (buffer-file-name)
                            (list :maxlevel 0
                                  :tstart (format-time t1)
                                  :tend (format-time t2))))))
      (let* ((start
              (seconds-to-time
               (org-matcher-time (plist-get params :tstart))))
             (current-time start)
             (end
              (seconds-to-time
               (org-matcher-time (plist-get params :tend))))
             (total-days-worked 0))
        (progn
          ;; loop through all the days in the time frame provided
          ;; and count how many days minutes were reported.
          (while (time-less-p current-time end)
            (let* ((next-day
                    (time-add
                     current-time (date-to-time "1970-01-02T00:00Z")))
                   (minutes-in-day
                    (get-minutes-from-log current-time next-day)))
              (if (> minutes-in-day 0)
                  (cl-incf total-days-worked 1))
              (setq current-time next-day)))
          ;; now we can just do some simple arithmetic to get the
          ;; difference between hours ideally worked and hours
          ;; actually worked.
          (let* ((total-minutes-worked
                  (get-minutes-from-log start end))
                 (hours-worked (/ total-minutes-worked 60.0))
                 (hours-per-workday 8)
                 (hours-should-work
                  (* total-days-worked hours-per-workday))
                 (hour-difference
                  (- hours-worked hours-should-work)))
            (insert (format "%0.1f" hour-difference)))))))
```

A clock table, or report, is basically a view onto the raw logbook data. It's called _table_ because it normally takes the form of one; mine doesn't, but I will call it that anyway. You use this one like you do any other org-mode clock table, only you also need to remember to supply the `:tstart` and `:tend` arguments:

```lisp
:LOGBOOK:...
#+BEGIN: work-report :tstart "<2022-01-10>" :tend "<now>"
#+END:
```

Then you move the cursor over the `#+BEGIN: ... #+END:` block and do `org-ctrl-c-ctrl-c` (`C-c C-c`). That gets you the hour balance:

```lisp
:LOGBOOK:...
#+BEGIN: work-report :tstart "<2022-01-10>" :tend "<now>"
1.0
#+END:
```

One limitation is that the algorithm assumes that any day you worked on is a day on which you should have worked the full number of hours. So if I log a session that goes from Friday afternoon to after midnight (that is, early Saturday morning), it assumes I should have worked 16 hours those days, whereas in fact only Friday was a workday. I solve this by editing my hour reports manually whenever this happens.

(Thanks to Lei Zhao whose [answer on the Emacs Stack Exchange](https://emacs.stackexchange.com/a/59239), though it was not solving the same problem, still put me on the right path.)
