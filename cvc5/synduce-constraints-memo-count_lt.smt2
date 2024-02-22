(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((TreeMemo 0))
  (((Mleaf (proj1-Mleaf Nat) (proj2-Mleaf Nat))
    (Mnode (proj1-Mnode Nat)
      (proj2-Mnode Nat) (proj3-Mnode TreeMemo) (proj4-Mnode TreeMemo)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf4
  ((x TreeMemo)) Tree
  (match x
    (((Mleaf tv19 tv20) (Leaf tv20))
     ((Mnode tv21 tv22 tv23 tv24) (Node tv22 (tf4 tv23) (tf4 tv24))))))
(define-fun
  tf0
  ((x TreeMemo)) Nat
  (match x
    (((Mleaf tv1 tv2) tv1)
     ((Mnode tv3 tv4 tv5 tv6) tv3))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  nateq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero
      (match y
        ((Zero True)
         ((Succ z) False))))
     ((Succ x2)
      (match y
        ((Zero False)
         ((Succ y2) (nateq x2 y2))))))))
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
  ite5
  ((x Bool2) (y TreeMemo) (z TreeMemo)) TreeMemo
  (match x
    ((True y)
     (False z))))
(define-fun
  tf8
  ((x TreeMemo) (y TreeMemo)) TreeMemo
  (match y
    (((Mleaf tv35 tv36) (ite5 (lq tv36 (Succ (Succ Zero))) x x))
     ((Mnode tv37 tv38 tv39 tv40)
      (ite5 (lq tv38 (Succ (Succ Zero))) x x)))))
(define-fun
  tf7
  ((x TreeMemo)) TreeMemo (tf8 x x))
(define-fun
  ite4
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  tf6
  ((x Tree)) Nat
  (match x
    (((Leaf tv28) (ite4 (lq tv28 (Succ (Succ Zero))) (Succ Zero) Zero))
     ((Node tv29 tv30 tv31)
      (ite4 (lq tv29 (Succ (Succ Zero)))
        (plus (Succ Zero) (plus (tf6 tv30) (tf6 tv31)))
        (plus (tf6 tv30) (tf6 tv31)))))))
(define-fun
  ite3
  ((x Bool2) (y Bool2) (z Bool2)) Bool2
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  geq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero
      (match y
        ((Zero True)
         ((Succ z) False))))
     ((Succ x2)
      (match y
        ((Zero True)
         ((Succ y2) (geq x2 y2))))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf2
  ((x TreeMemo)) Bool2
  (match x
    (((Mleaf tv10 tv11)
      (and2 (geq tv10 Zero)
        (ite3 (lq tv11 (Succ (Succ Zero)))
          (nateq tv10 (Succ Zero)) (nateq tv10 Zero))))
     ((Mnode tv12 tv13 tv14 tv15)
      (and2
        (and2 (geq tv12 Zero)
          (nateq tv12
            (plus (ite4 (lq tv13 (Succ (Succ Zero))) (Succ Zero) Zero)
              (plus (tf0 tv14) (tf0 tv15)))))
        (and2 (tf2 tv14) (tf2 tv15)))))))
(define-fun
  main
  ((x TreeMemo)) Nat (ite4 (tf2 x) (tf6 (tf4 (tf7 x))) Zero))
(define-fun
  mainNew
  ((x TreeMemo)) Nat (ite4 (tf2 x) (tf0 x) Zero))
(assert
  (not (forall ((inp0 TreeMemo)) (= (main inp0) (mainNew inp0)))))
(check-sat)
