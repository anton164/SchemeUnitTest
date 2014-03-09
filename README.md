SchemeUnitTest
==============

Initiated at a Functional Programming Course at UiO, **INF2810**  
This **is** an attempt at reinventing the wheel.  
**Purpose:** learn more about Scheme, Functional Programming and Test Driven Development by developing SchemeUnitTest.

### Usage:
```Scheme
(load "SchemeUnitTest/sunit.scm")
;; (unit-test "NAME OF YOUR TEST" PREDICATE ExpectedValue FunctionCallToTest)
(unit-test "2 = 2" = 2 (+ 1 1))

(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))
(unit-test "6 = 3!" = 6 (fact 3))
```

A simple automatic test runner is included which polls for file changes for a specificed source (file/folder) every **x** seconds.  
**Usage:** `python test-runner.py test_file wait_time source (+source)`  
**Example:** `python test-runner.py 'tests.scm' 5 'src/' 'othersrc/otherfile.scm'`
