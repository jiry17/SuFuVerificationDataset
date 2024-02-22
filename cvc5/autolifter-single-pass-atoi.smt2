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
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun-rec
  tf4
  ((x List2)) Nat
  (match x
    (((Cons tv14 tv15)
      (plus
        (times
          (Succ
            (Succ
              (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero))))))))))
          (tf4 tv15))
        tv14))
     ((Nil tv13) Zero))))
(define-fun
  tf2
  ((x List2)) Nat (tf4 (tf0 x)))
(define-fun-rec
  tf6
  ((x List2)) Nat
  (match x
    (((Cons tv22 tv23)
      (plus tv22
        (times (tf6 tv23)
          (Succ
            (Succ
              (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))))))))
     ((Nil tv21) Zero))))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf6 inp0)))))
(check-sat)
