(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Cnil (proj1-Cnil Unit)) (Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Nil tv8) x)
      ((Cons tv6 tv7) (Cons tv6 (tf0 tv7 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Cnil tv12) (Nil Null))
     ((Single tv13) (Cons tv13 (Nil Null)))
     ((Concat tv14 tv15) (tf0 (tf3 tv14) (tf3 tv15))))))
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
    (((Nil tv19) Zero)
     ((Cons tv20 tv21) (plus tv20 (tf5 tv21))))))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Cnil tv26) Zero)
     ((Single tv27) tv27)
     ((Concat tv28 tv29) (plus (tf7 tv28) (tf7 tv29))))))
(define-fun
  main
  ((x CList)) Nat (tf5 (tf3 x)))
(assert (not (forall ((inp0 CList)) (= (main inp0) (tf7 inp0)))))
(check-sat)
