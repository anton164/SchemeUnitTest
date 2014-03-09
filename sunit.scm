;; SchemeUnitTest

;; Helper methods
(define (all? pred lst)
  (if (null? lst)
      #t
      (and (pred (car lst)) (all? pred (cdr lst)))))

(define (reduce f lst)
  (if (null? lst)
      0
      (f (car lst) (reduce f (cdr lst)))))

(define (substring? str substr)
  (define (string-has-char? str char)
    (member char (string->list str)))
    (if (or (= (string-length substr) 0) (equal? str substr))
          #t
        (if (= (string-length str) 0)
          #f
          (all? (lambda (char) (string-has-char? str char)) (string->list substr)))))

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
      (string-append "Test '" name "' passed.")
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
  (define (run-tests tests)
    (map (lambda (x) (apply unit-test x)) tests))
  (define (test-result->succfail results)
    ;; Convert test results to a pair of numbers representing successful and failed tests.
    (cons 
     (reduce + (map (lambda (result) (if (substring? result " passed.") 1 0)) results)) ;; successful tests
     (reduce + (map (lambda (result) (if (substring? result " failed!") 1 0)) results)))) ;; failed tests
  (define (final-result succfail)
    (let* ((success (car succfail))
           (fails (cdr succfail))
           (num-tests (+ success fails)))
      (if (> fails 0)
          (string-append "Test block failed.\n"
                         (number->string success) " out of " (number->string num-tests) " tests passed.")
          (string-append "Test block successful.\n"
                         (number->string success) " out of " (number->string num-tests) " tests passed."))))
  (begin
    (let* ((test-result (run-tests tests))
      (succfail (test-result->succfail test-result)))
    (display (string-append "Running test-block: " name "\n"))
    (display "---------------------------\n")
    (output test-result)
    (display "---------------------------\n")
    (display (string-append (final-result succfail) "\n\n")))))

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

