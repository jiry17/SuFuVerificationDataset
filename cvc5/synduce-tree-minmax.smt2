(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf5
  ((x Tree)) Tree
  (match x
    (((Leaf tv23) (Leaf tv23))
     ((Node tv24 tv25 tv26) (Node tv24 (tf5 tv25) (tf5 tv26))))))
(define-fun
  snd2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x1))))
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
  gq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero False)
     ((Succ x1)
      (match y
        ((Zero True)
         ((Succ z) (gq x1 z))))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite1 (gq x y) y x))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf1
  ((x Tuple2) (y Tree)) Tuple2
  (match y
    (((Leaf tv10) (MakeTuple2 (min tv10 (fst2 x)) (max tv10 (snd2 x))))
     ((Node tv11 tv12 tv13)
      (tf1
        (tf1 (MakeTuple2 (min tv11 (fst2 x)) (max tv11 (snd2 x))) tv12)
        tv13)))))
(define-fun
  tf3
  ((x Tree)) Tuple2
  (match x
    (((Leaf tv16) (MakeTuple2 tv16 tv16))
     ((Node tv17 tv18 tv19)
      (tf1
        (MakeTuple2 (fst2 (tf1 (MakeTuple2 tv17 tv17) tv18))
          (snd2 (tf1 (MakeTuple2 tv17 tv17) tv18)))
        tv19)))))
(define-fun
  main
  ((x Tree)) Tuple2 (tf3 (tf5 x)))
(define-fun-rec
  tf7
  ((x Tree)) Tuple2
  (match x
    (((Leaf tv31) (MakeTuple2 tv31 tv31))
     ((Node tv32 tv33 tv34)
      (MakeTuple2 (min (fst2 (tf7 tv33)) (min (fst2 (tf7 tv34)) tv32))
        (max (snd2 (tf7 tv33)) (max (snd2 (tf7 tv34)) tv32)))))))
(define-fun
  mainNew
  ((x Tree)) Tuple2 (MakeTuple2 (fst2 (tf7 x)) (snd2 (tf7 x))))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
