(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Nil (proj1-Nil Unit))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(define-fun-rec
  tf3
  ((x Tree)) Tree
  (match x
    (((Nil tv12) (Nil Null))
     ((Node tv13 tv14 tv15) (Node tv13 (tf3 tv14) (tf3 tv15))))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x Nat) (y Tree)) Nat
  (match y
    (((Nil tv5) x)
     ((Node tv6 tv7 tv8) (tf1 (plus (tf1 x tv7) tv6) tv8)))))
(define-fun
  spec
  ((x Tree)) Nat (tf1 Zero x))
(define-fun-rec
  tf5
  ((x Tree)) Nat
  (match x
    (((Nil tv20) Zero)
     ((Node tv21 tv22 tv23) (plus (tf5 tv23) (plus (tf5 tv22) tv21))))))
(define-fun
  main
  ((x Tree)) Nat (spec (tf3 x)))
(assert (not (forall ((inp0 Tree)) (= (main inp0) (tf5 inp0)))))
(check-sat)
