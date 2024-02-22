(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(define-funs-rec
  ((tf2
    ((x List2) (y Nat)) List2)
   (tf3
    ((x Nat) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Nil tv12) (Cons x (Nil Null)))
      ((Cons tv13 tv14) (Cons tv13 (tf2 tv14 x)))))))
(define-fun-rec
  tf5
  ((x List2) (y List2)) List2
  (match y
    (((Nil tv20) x)
     ((Cons tv21 tv22) (tf5 (tf2 x tv21) tv22)))))
(define-fun
  repr
  ((x List2)) List2 (tf5 (Nil Null) x))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x List2)) Nat
  (match x
    (((Nil tv3) Zero)
     ((Cons tv4 tv5) (plus tv4 (tf1 tv5))))))
(define-fun-rec
  tf7
  ((x Nat) (y List2)) Nat
  (match y
    (((Nil tv29) x)
     ((Cons tv30 tv31) (tf7 (plus x tv30) tv31)))))
(define-fun
  reprNew
  ((x List2)) Nat (tf7 Zero x))
(define-fun
  main
  ((x List2)) Nat (tf1 (repr x)))
(assert
  (not (forall ((inp0 List2)) (= (main inp0) (reprNew inp0)))))
(check-sat)
