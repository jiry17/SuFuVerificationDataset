(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((TreeMemo 0))
  (((Mleaf (proj1-Mleaf Nat))
    (Mnode (proj1-Mnode Nat)
      (proj2-Mnode Nat) (proj3-Mnode TreeMemo) (proj4-Mnode TreeMemo)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun
  tf6
  ((x TreeMemo)) TreeMemo x)
(define-fun
  tf5
  ((x TreeMemo)) TreeMemo x)
(define-fun-rec
  tf4
  ((x TreeMemo)) Tree
  (match x
    (((Mleaf tv17) (Leaf tv17))
     ((Mnode tv18 tv19 tv20 tv21) (Node tv19 (tf4 tv20) (tf4 tv21))))))
(define-fun
  tf0
  ((x TreeMemo)) Nat
  (match x
    (((Mleaf tv1) (Succ Zero))
     ((Mnode tv2 tv3 tv4 tv5) tv2))))
(define-fun
  target
  ((x TreeMemo)) TreeMemo x)
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf8
  ((x Tree)) Nat
  (match x
    (((Leaf tv32) (Succ Zero))
     ((Node tv33 tv34 tv35)
      (plus (Succ Zero) (plus (tf8 tv34) (tf8 tv35)))))))
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
(define-fun
  ite2
  ((x Bool2) (y Nat)) Nat
  (match x
    ((True y)
     (False Zero))))
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
    (((Mleaf tv9) True)
     ((Mnode tv10 tv11 tv12 tv13)
      (and2 (nateq tv10 (plus (Succ Zero) (plus (tf0 tv12) (tf0 tv13))))
        (and2 (tf2 tv12) (tf2 tv13)))))))
(define-fun
  main
  ((x TreeMemo)) Nat (ite2 (tf2 x) (tf8 (tf4 x))))
(define-fun
  mainNew
  ((x TreeMemo)) Nat (ite2 (tf2 x) (tf0 x)))
(assert
  (not (forall ((inp0 TreeMemo)) (= (main inp0) (mainNew inp0)))))
(check-sat)
