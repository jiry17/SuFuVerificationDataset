(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((BTree 0))
  (((Empty (proj1-Empty Unit))
    (Node (proj1-Node Nat) (proj2-Node BTree) (proj3-Node BTree)))))
(declare-datatypes ((Zipper 0))
  (((Top (proj1-Top Unit))
    (Left (proj1-Left Nat) (proj2-Left BTree) (proj3-Left Zipper))
    (Right (proj1-Right Nat)
      (proj2-Right BTree) (proj3-Right Zipper)))))
(define-fun-rec
  tf3
  ((x Zipper)) BTree
  (match x
    (((Top tv12) (Empty Null))
     ((Left tv13 tv14 tv15) (Node tv13 tv14 (tf3 tv15)))
     ((Right tv16 tv17 tv18) (Node tv16 (tf3 tv18) tv17)))))
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
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) y x))
(define-fun-rec
  tf1
  ((x BTree)) Nat
  (match x
    (((Empty tv5) Zero)
     ((Node tv6 tv7 tv8) (plus tv6 (max (tf1 tv7) (tf1 tv8)))))))
(define-fun
  main
  ((x Zipper)) Nat (tf1 (tf3 x)))
(define-fun-rec
  tf5
  ((x Zipper)) Nat
  (match x
    (((Top tv23) Zero)
     ((Left tv24 tv25 tv26) (plus tv24 (max (tf5 tv26) (tf1 tv25))))
     ((Right tv27 tv28 tv29) (plus tv27 (max (tf5 tv29) (tf1 tv28)))))))
(assert (not (forall ((inp0 Zipper)) (= (main inp0) (tf5 inp0)))))
(check-sat)
