(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Nil (proj1-Nil Unit)) (Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf7
  ((x Tree)) Tree
  (match x
    (((Nil tv27) (Nil Null))
     ((Leaf tv28) (Leaf tv28))
     ((Node tv29 tv30 tv31) (Node tv29 (tf7 tv30) tv31)))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x Tree)) Nat
  (match x
    (((Nil tv3) Zero)
     ((Leaf tv4) (Succ Zero))
     ((Node tv5 tv6 tv7)
      (plus (Succ Zero) (plus (tf1 tv6) (tf1 tv7)))))))
(define-fun-rec
  tf5
  ((x Tree)) Nat
  (match x
    (((Nil tv19) Zero)
     ((Leaf tv20) tv20)
     ((Node tv21 tv22 tv23) (plus tv21 (plus (tf5 tv22) (tf5 tv23)))))))
(define-fun-rec
  tf9
  ((x Tree)) Nat
  (match x
    (((Nil tv36) Zero)
     ((Leaf tv37) tv37)
     ((Node tv38 tv39 tv40) (plus (tf9 tv39) tv38)))))
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
  ite1
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
  tf3
  ((x Tree)) Bool2
  (match x
    (((Nil tv14) True)
     ((Leaf tv15) True)
     ((Node tv11 tv12 tv13)
      (and2 (nateq Zero (tf1 tv13)) (tf3 tv12))))))
(define-fun
  main
  ((x Tree)) Nat (ite1 (tf3 x) (tf5 (tf7 x))))
(define-fun
  mainNew
  ((x Tree)) Nat (ite1 (tf3 x) (tf9 x)))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
