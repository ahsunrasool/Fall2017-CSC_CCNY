

; CSc 335
; Fall 2015

; October 13

; First 1.25 Hour Exam

; Professor Troeger


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TYPE YOUR NAME HERE:

; TYPE YOUR FULL EMAIL ADDRESS HERE:
; (I will email your graded paper to this address)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Scoring Template - Do NOT Erase!

;;;; Problem 1 - code (out of 15 points)
;;;; Problem 1 - proof (out of 10 points)

;;;; Problem 2 - code (out of 10 points)
;;;; Problem 2 - proof (out of 15 points)

;;;; Problem 3 - code (out of 20 points)
;;;; Problem 3 - proof (out of 20 points)

;;;; Problem 4 (out of 10 points)

;;;; Total
;;;; Letter Grade

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; You have full access to drracket for this exam. All problems are to be solved using R5RS within drracket,
; and using only language features discussed so far in the context of the homework: no lists, no strings, no assignment.  

; Collaboration of any kind is not permitted: you are to work alone; email and internet access have been disabled.

; Smart phones are to be switched off and placed on the desk in front of you.  They are not to leave the room.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; YOU SHOULD INSERT YOUR ANSWERS INTO THE EXAM DIRECTLY FOLLOWING EACH QUESTION.

; BE SURE TO SAVE YOUR WORK FREQUENTLY.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Here are the examination problems.  


; Problem 1 (25 points) Write a scheme function expo of one integer argument b which returns a function of
; one argument e so that, for e a non-negative integer, ((expo b) e) returns b raised to the eth power.
; The function returned by (expo b) should work by repeated multiplication, and should be be properly
; recursive; give a proof that this function is correct.  Don't forget the termination argument.

(display "\n Question 1 \n")
(define (expo b)
  (define (raise e)
    (if (= e 0) 1
        (* b (raise (- e 1)))
    )
  )
  raise
)

((expo 2) 3)

(define (power b)
  (lambda (n) (cond ((= n 0) b)
                    (else ((- n 1) (*b b))))))
(power 3)
; Problem 2 (25 points) Design and certify an iterative scheme procedure count-digits which inputs a single
; non-negative integer n and which returns the number of digits in n.  Your proof should be based on an
; invariant.  Again, do not forget the termination argument.   

(display "\n Question 2 \n")
(define (count-digits n)
  (define (get-length num length)
    (if (= num 0) length
        (get-length (quotient num 10) (+ length 1))
    )
  )
  (get-length n 0)
)

(count-digits 123456789)

; Problem 3 (40 points)  Write and certify a scheme function scramble with arguments n and f, where n is a
; positive integer and f is a function from the set {0,1,2,...,9} of digits to the set of non-negative
; integers, and which returns the number formed from n by replacing each digit j by the digits (in order)
; of the value (f j).

; Thus if f is the function which squares each digit, (scramble 403612 f) returns 16093614

; Your function can be either recursive or iterative, as you see fit: be sure to say which, and to give
; a proof (induction or invariant based) which matches your choice. Again, don't forget the termination argument.

(display "\n Question 3 \n")
(define (square x) (* x x))
(define (cube x) (* x x x))

(define (scramble value term)
  (if (= (count-digits value) 1) (square value)
      (scramble-iter value term 0 0)
  )
)

(define (scramble-iter num term length result)
  ;(display num)(display " ")(display length)(display " ")(display result)(display "\n")
  (if (= num 0) result
      (if (= (modulo num 10) 0)
          (scramble-iter (quotient num 10)
                         term
                         (expt 10 (count-digits length))
                         (+ result (* (expt 10 (count-digits length)) (term (modulo num 10)))))
          (scramble-iter (quotient num 10)
                         term
                         (+ length (* (expt 10 (count-digits length)) (term (modulo num 10))))
                         (+ result (* (expt 10 (count-digits length)) (term (modulo num 10)))))
      )
  )
)

(scramble 403612 square)

; (Hint: work from the right, and perhaps make use of your function count-digits. Your proof, should you use
; count-digits, will need to show that the count-digits precondition holds each time it is called; your proof should also
; indicate how the post-condition of count-digits contributes to the main argument. )


; Problem 4 (10 points) The function

(display "\n Question 4 \n")
(define add-1
  (lambda (y) (+ y 1)))

; can be generalized

(define add-x
  (lambda (x)
    (lambda (y)
      (+ x y))))

; so that add-1 can be realized as (add-x 1).

; In this problem, you are asked to go a step further, and generalize this pattern to allow its use with any function
; of two arguments (not just +).  Name the new function curry-2, and show how to use it to realize add-x.  Show
; further how to use it to define a function expo-b, which inputs a non-negative integer e and outputs b raised to the eth
; power (you can use the scheme primitive, expt).

; No proofs are required for problem 4.

(define add-x
  (lambda (x)
    (lambda (y)
      (lambda (z)
        (z x y)))))

(define (curry-2 x y z)
  (((add-x x) y) z)
)

(curry-2 1 2 +)

(define (expo-b b e)
  (if (= e 0) 1
      (* b (expo-b b (- e 1)))
  )
)

(curry-2 5 3 expo-b)








