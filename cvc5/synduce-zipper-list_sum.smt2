(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Zipper 0))
  (((Zip (proj1-Zip List2) (proj2-Zip List2)))))
(define-fun-rec
  tf5
  ((x List2)) List2
  (match x
    (((Nil tv18) (Nil Null))
     ((Cons tv19 tv20) (Cons tv19 (tf5 tv20))))))
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
  tf8
  ((x Zipper)) List2
  (match x (((Zip tv28 tv29) (tf0 (tf3 tv28) (tf5 tv29))))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf10
  ((x List2)) Nat
  (match x
    (((Nil tv34) Zero)
     ((Cons tv35 tv36) (plus tv35 (tf10 tv36))))))
(define-fun-rec
  tf12
  ((x List2)) Nat
  (match x
    (((Nil tv40) Zero)
     ((Cons tv41 tv42) (plus (tf12 tv42) tv41)))))
(define-fun
  tf13
  ((x Zipper)) Nat
  (match x (((Zip tv44 tv45) (plus (tf10 tv44) (tf12 tv45))))))
(define-fun-rec
  tf7
  ((x List2)) Nat
  (match x
    (((Nil tv24) Zero)
     ((Cons tv25 tv26) (plus tv25 (tf7 tv26))))))
(define-fun
  main
  ((x Zipper)) Nat (tf7 (tf8 x)))
(assert (not (forall ((inp0 Zipper)) (= (main inp0) (tf13 inp0)))))
(check-sat)
