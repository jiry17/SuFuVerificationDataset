(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Nil (proj1-Nil Unit))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf3
  ((x Tree)) Tree
  (match x
    (((Nil tv14) (Nil Null))
     ((Node tv15 tv16 tv17) (Node tv15 (tf3 tv16) (tf3 tv17))))))
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
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite1 (lq x y) y x))
(define-fun-rec
  tf1
  ((x Nat) (y Tree)) Nat
  (match y
    (((Nil tv7) x)
     ((Node tv8 tv9 tv10)
      (max (tf1 (plus x tv8) tv9) (tf1 (plus x tv8) tv10))))))
(define-fun
  spec
  ((x Tree)) Nat (tf1 Zero x))
(define-fun
  main
  ((x Tree)) Nat (spec (tf3 x)))
(define-fun-rec
  tf5
  ((x Tree)) Nat
  (match x
    (((Nil tv22) Zero)
     ((Node tv23 tv24 tv25) (plus tv23 (max (tf5 tv25) (tf5 tv24)))))))
(assert (not (forall ((inp0 Tree)) (= (main inp0) (tf5 inp0)))))
(check-sat)
