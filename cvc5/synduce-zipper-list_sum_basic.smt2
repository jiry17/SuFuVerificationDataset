(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Zipper 0))
  (((Zip (proj1-Zip List2) (proj2-Zip List2)))))
(define-fun
  tf8
  ((x Zipper)) Zipper x)
(define-fun
  tf7
  ((x Zipper)) Zipper x)
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Nil tv6) x)
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun-rec
  tf3
  ((x List2)) List2
  (match x
    (((Nil tv12) (Nil Null))
     ((Cons tv13 tv14) (tf0 (tf3 tv14) (Cons tv13 (Nil Null)))))))
(define-fun
  tf6
  ((x Zipper)) List2
  (match x (((Zip tv22 tv23) (tf0 (tf3 tv22) tv23)))))
(define-fun
  target
  ((x Zipper)) Zipper x)
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf5
  ((x List2)) Nat
  (match x
    (((Nil tv18) Zero)
     ((Cons tv19 tv20) (plus tv19 (tf5 tv20))))))
(define-fun
  tf10
  ((x Zipper)) Nat
  (match x (((Zip tv31 tv32) (plus (tf5 tv31) (tf5 tv32))))))
(define-fun
  main
  ((x Zipper)) Nat (tf5 (tf6 x)))
(assert (not (forall ((inp0 Zipper)) (= (main inp0) (tf10 inp0)))))
(check-sat)
