(define (tostring exp)
  (cond ((string? exp) exp)
         ((number? exp)
         (number->string exp))
         ((list? exp)
         (list->string exp))))

(define (unit-test name predicate expected try)
  (if (predicate expected try)
      (string-append "Test '" name "' passed")
      (string-append "Test '" name "' failed! " (tostring expected) 
                              " not equal to " (tostring try) "")))


(define (unit-tests . tests)
  (if (null? tests)
      "Tests passed" 
   (apply unit-tests (cdr tests))))

#! GOAL: Allow the following:
(unit-tests
   (list "Test 1" = 2 2)
   (list "Test 2" < 3 4))

#| Preferrable output:
Test run successful.
x out of y tests passed.
------------------------
Test run failed.
x out of y tests passed.
The following tests failed:
...
...
|#

(define tests
  (list (list "fact2=2" = 2 (* 2 1))
    (list "fact3=6" = 6 (* 3 2 1))))

