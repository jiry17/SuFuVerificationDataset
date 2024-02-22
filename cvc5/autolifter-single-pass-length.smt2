(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Nat) (proj2-Cons List2))
    (Nil (proj1-Nil Unit)))))
(define-funs-rec
  ((tf0
    ((x List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 x x)
   (match y
     (((Cons tv6 tv7) (Cons tv6 (tf0 tv7)))
      ((Nil tv5) x)))))
(define-fun-rec
  plus
  ((x Nat)) Nat
  (match x
    ((Zero (Succ Zero))
     ((Succ y) (Succ (plus y))))))
(define-fun-rec
  tf4
  ((x List2)) Nat
  (match x
    (((Cons tv13 tv14) (plus (tf4 tv14)))
     ((Nil tv15) Zero))))
(define-fun
  tf2
  ((x List2)) Nat (tf4 (tf0 x)))
(define-fun-rec
  tf6
  ((x List2)) Nat
  (match x
    (((Cons tv22 tv23) (plus (tf6 tv23)))
     ((Nil tv21) Zero))))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf6 inp0)))))
(check-sat)
