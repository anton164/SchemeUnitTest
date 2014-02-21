;; SchemeUnitTest
;; Built-in list->string only takes a list of characters

(define (tostring exp)
  (define (list-->string) exp
  "Not implemented")
  (cond ((string? exp) exp)
         ((number? exp)
         (number->string exp))
         ((list? exp)
         (list-->string exp))))

(define (unit-test name predicate expected try)
  (if (predicate expected try)
      (string-append "Test '" name "' passed")
      (string-append "Test '" name "' failed! Expected: " (tostring expected) 
                              " Returned: " (tostring try) "")))

(define (unit-tests . tests)
  (define (apply-aux f g)
    (lambda (x)
      (f g x)))
  (define (output test-results)
    (if (not (null? test-results))
        (begin
          (display (string-append (car test-results) "\n"))
          (output (cdr test-results)))))
  (define (run-tests tests t-success t-fail)
    (map (apply-aux apply unit-test) tests))
  (begin
    (output (run-tests tests 0 0))
    (display "---------------------------\n")
    (display "Test run complete.\n")))

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

