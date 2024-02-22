(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Bool2) (proj2-Cons List2))
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
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf6
  ((x List2)) Nat
  (match x
    (((Cons tv24 tv25)
      (match tv24
        ((True Zero)
         (False (plus (Succ Zero) (tf6 tv25))))))
     ((Nil tv23) Zero))))
(define-fun
  not2
  ((x Bool2)) Bool2
  (match x
    ((True False)
     (False True))))
(define-fun
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  tf4
  ((x Nat) (y List2)) Nat
  (match y
    (((Cons tv16 tv17) (ite1 tv16 x (tf4 (plus (Succ Zero) x) tv17)))
     ((Nil tv15) x))))
(define-fun
  dropwhile
  ((x List2)) Nat (tf4 Zero x))
(define-fun
  tf2
  ((x List2)) Nat (dropwhile (tf0 x)))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf6 inp0)))))
(check-sat)
