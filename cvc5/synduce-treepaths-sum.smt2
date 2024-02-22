(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
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
    (((Top tv10) (Empty Null))
     ((Left tv11 tv12 tv13) (Node tv11 tv12 (tf3 tv13)))
     ((Right tv14 tv15 tv16) (Node tv14 (tf3 tv16) tv15)))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x BTree)) Nat
  (match x
    (((Empty tv3) Zero)
     ((Node tv4 tv5 tv6) (plus tv4 (plus (tf1 tv5) (tf1 tv6)))))))
(define-fun-rec
  tf5
  ((x Zipper)) Nat
  (match x
    (((Top tv21) Zero)
     ((Left tv22 tv23 tv24) (plus (tf5 tv24) (plus tv22 (tf1 tv23))))
     ((Right tv25 tv26 tv27)
      (plus (tf5 tv27) (plus tv25 (tf1 tv26)))))))
(define-fun
  main
  ((x Zipper)) Nat (tf1 (tf3 x)))
(assert (not (forall ((inp0 Zipper)) (= (main inp0) (tf5 inp0)))))
(check-sat)
