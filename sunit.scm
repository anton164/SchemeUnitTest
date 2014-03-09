;; SchemeUnitTest
;; Built-in list->string only takes a list of characters

(define (tostring exp)
  (define (list-->string lst)
    (define (aux lst)
      (if (null? lst)
          ")"
          (string-append " " (tostring (car lst)) " " (aux (cdr lst)))))
    (string-append "(" (aux lst)))
  (cond ((string? exp) exp)
         ((number? exp)
         (number->string exp))
         ((list? exp)
         (list-->string exp))
         ((procedure? exp)
         "Procedure")
         (else "Unknown type (quote?)")))

(define (unit-test name predicate expected try)
  (if (predicate expected try)
      (string-append "Test '" name "' passed")
      (string-append "Test '" name "' failed! Expected: " (tostring expected) 
                              " Returned: " (tostring try) "")))

(define (unit-tests name . tests)
  (define (apply-aux f g)
    (lambda (x)
      (f g x)))
  (define (output test-results)
    (if (not (null? test-results))
        (begin
          (display (string-append (car test-results) "\n"))
          (output (cdr test-results)))))
  (define (run-tests tests t-success t-fail)
    (map (lambda (x) (apply unit-test x)) tests))
  (begin
    (display (string-append "Running test-block: " name "\n"))
    (display "---------------------------\n")
    (output (run-tests tests 0 0))
    (display "---------------------------\n")
    (display "Test block complete.\n")))

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

