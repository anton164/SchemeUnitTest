SchemeUnitTest
==============

Initiated at a Functional Programming Course at UiO, INF2810
Purpose: learn more about Scheme, Functional Programming and Test Driven Development by developing SchemeUnitTest.

### Usage:
    (load "SchemeUnitTest/sunit.scm")
    ;; (unit-test "NAME OF YOUR TEST" PREDICATE ExpectedValue FunctionCallToTest)
    (unit-test "2 = 2" = 2 (+ 1 1))
    
    (define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))
    (unit-test "6 = 3!" = 6 (fact 3))
