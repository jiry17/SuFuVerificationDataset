(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Nat) (proj2-Cons List2))
    (Nil (proj1-Nil Unit)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
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
  lq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero
      (match y
        ((Zero False)
         ((Succ z) True))))
     ((Succ x2)
      (match y
        ((Zero False)
         ((Succ y2) (lq x2 y2))))))))
(define-fun
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  tf4
  ((x List2)) Nat
  (match x
    (((Cons tv14 tv15)
      (ite1 (lq Zero (plus (tf4 tv15) tv14))
        Zero (plus (tf4 tv15) tv14)))
     ((Nil tv13) Zero))))
(define-fun
  tf2
  ((x List2)) Nat (tf4 (tf0 x)))
(define-fun-rec
  tf6
  ((x List2)) Nat
  (match x
    (((Cons tv22 tv23)
      (ite1 (lq (plus tv22 (tf6 tv23)) Zero)
        (plus tv22 (tf6 tv23)) Zero))
     ((Nil tv21) Zero))))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf6 inp0)))))
(check-sat)
