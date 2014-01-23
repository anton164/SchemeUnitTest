(define (tostring exp)
  (cond ((string? exp) exp)
         ((number? exp)
         (number->string exp))
         ((list? exp)
         (list->string exp))))

(define (unit-test name predicate expected try)
  (if (predicate expected try)
      (display (string-append "Test '" name "' passed\n"))
      (display (string-append "Test '" name "' failed! " (tostring expected) 
                              " not equal to " (tostring try) "\n"))))

#! GOAL: Allow the following:
;; (unit-tests
;;   ("Test 1" = 2 2)
;;   ("Test 2" < 3 4))

(define (unit-tests tests)
  (apply unit-test tests))

(define tests
  '(("fact2=2" = 2 (fact 2))
    ("fact3=6" = 6 (fact 3))))

