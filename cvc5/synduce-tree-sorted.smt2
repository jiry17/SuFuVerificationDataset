(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple1 0))
  (((MakeTuple1 (proj1-MakeTuple1 Nat) (proj2-MakeTuple1 Bool2)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Bool2) (proj2-MakeTuple2 Nat)))))
(define-fun-rec
  tf3
  ((x Tree)) Tree
  (match x
    (((Leaf tv10) (Leaf tv10))
     ((Node tv11 tv12 tv13) (Node tv11 (tf3 tv12) (tf3 tv13))))))
(define-fun
  snd2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x1))))
(define-fun
  snd1
  ((x Tuple1)) Bool2 (match x (((MakeTuple1 x0 x1) x1))))
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
  fst2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1) x0))))
(define-fun
  fst1
  ((x Tuple1)) Nat (match x (((MakeTuple1 x0 x1) x0))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf1
  ((x Tree)) Tuple1
  (match x
    (((Leaf tv3) (MakeTuple1 tv3 True))
     ((Node tv4 tv5 tv6)
      (MakeTuple1 tv4
        (and2
          (and2 (and2 (lq (fst1 (tf1 tv5)) tv4) (lq tv4 (fst1 (tf1 tv6))))
            (snd1 (tf1 tv5)))
          (snd1 (tf1 tv6))))))))
(define-fun
  spec
  ((x Tree)) Bool2 (snd1 (tf1 x)))
(define-fun
  main
  ((x Tree)) Bool2 (spec (tf3 x)))
(define-fun-rec
  tf5
  ((x Tree)) Tuple2
  (match x
    (((Leaf tv18) (MakeTuple2 True tv18))
     ((Node tv19 tv20 tv21)
      (MakeTuple2
        (and2
          (and2 (and2 (lq (snd2 (tf5 tv20)) tv19) (fst2 (tf5 tv21)))
            (fst2 (tf5 tv20)))
          (lq tv19 (snd2 (tf5 tv21))))
        tv19)))))
(define-fun
  mainNew
  ((x Tree)) Bool2 (fst2 (tf5 x)))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
