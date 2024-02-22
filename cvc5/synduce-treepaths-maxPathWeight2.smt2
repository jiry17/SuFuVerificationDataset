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
  tf5
  ((x BTree)) BTree
  (match x
    (((Empty tv22) (Empty Null))
     ((Node tv23 tv24 tv25) (Node tv23 (tf5 tv24) (tf5 tv25))))))
(define-fun-rec
  tf7
  ((x Zipper)) Zipper
  (match x
    (((Top tv29) (Top Null))
     ((Left tv30 tv31 tv32) (Left tv30 (tf5 tv31) (tf7 tv32)))
     ((Right tv33 tv34 tv35) (Right tv33 (tf5 tv34) (tf7 tv35))))))
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
  ((x Zipper)) Nat (tf1 (tf3 (tf7 x))))
(define-fun-rec
  tf9
  ((x BTree)) Nat
  (match x
    (((Empty tv40) Zero)
     ((Node tv41 tv42 tv43) (plus tv41 (max (tf9 tv43) (tf9 tv42)))))))
(define-fun-rec
  tf11
  ((x Zipper)) Nat
  (match x
    (((Top tv47) Zero)
     ((Left tv48 tv49 tv50) (plus tv48 (max (tf11 tv50) (tf9 tv49))))
     ((Right tv51 tv52 tv53)
      (plus tv51 (max (tf11 tv53) (tf9 tv52)))))))
(assert (not (forall ((inp0 Zipper)) (= (main inp0) (tf11 inp0)))))
(check-sat)
