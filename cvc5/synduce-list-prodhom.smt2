(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Cnil (proj1-Cnil Unit)) (Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Nil tv12) x)
      ((Cons tv13 tv14) (Cons tv13 (tf2 tv14 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Cnil tv18) (Nil Null))
     ((Single tv19) (Cons tv19 (Nil Null)))
     ((Concat tv20 tv21) (tf2 (tf5 tv20) (tf5 tv21))))))
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
  tf1
  ((x List2)) Nat
  (match x
    (((Nil tv3) (Succ Zero))
     ((Cons tv4 tv5) (times tv4 (tf1 tv5))))))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Cnil tv26) (Succ Zero))
     ((Single tv27) tv27)
     ((Concat tv28 tv29) (times (tf7 tv29) (tf7 tv28))))))
(define-fun
  main
  ((x CList)) Nat (tf1 (tf5 x)))
(assert (not (forall ((inp0 CList)) (= (main inp0) (tf7 inp0)))))
(check-sat)
