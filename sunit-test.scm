(load "sunit.scm")

;; Tests that the unit-tester is working
(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))
(unit-test "fact2=2" = 2 (fact 2))
(unit-test "2=2" = 2 (+ 1 1))


;; Tests for tostring
(unit-test "int 2 -> str 2" string=? "2" (tostring 2))
(unit-test "str 3 -> str 3" string=? "3" (tostring "3"))

;; Multiple tests in a block
(unit-tests "Testing block"
   (list "Test 1" = 2 2)
   (list "Test 2" < 3 4))

