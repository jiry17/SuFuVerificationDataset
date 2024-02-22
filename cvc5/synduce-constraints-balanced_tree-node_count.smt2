(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Nil (proj1-Nil Unit))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf7
  ((x Tree)) Tree
  (match x
    (((Nil tv26) (Nil Null))
     ((Node tv27 tv28 tv29) (Node tv27 (tf7 tv28) tv29)))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf5
  ((x Tree)) Nat
  (match x
    (((Nil tv19) Zero)
     ((Node tv20 tv21 tv22)
      (plus (Succ Zero) (plus (tf5 tv21) (tf5 tv22)))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
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
  ((x Tree)) Nat
  (match x
    (((Nil tv5) Zero)
     ((Node tv6 tv7 tv8)
      (plus (Succ Zero) (max (tf1 tv7) (tf1 tv8)))))))
(define-fun-rec
  tf9
  ((x Tree)) Nat
  (match x
    (((Nil tv34) Zero)
     ((Node tv35 tv36 tv37)
      (plus (times (Succ (Succ Zero)) (tf9 tv36))
        (max (tf9 tv36) (Succ Zero)))))))
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
    (((Nil tv12) True)
     ((Node tv13 tv14 tv15)
      (and2 (and2 (nateq (tf1 tv14) (tf1 tv15)) (tf3 tv14))
        (tf3 tv15))))))
(define-fun
  main
  ((x Tree)) Nat (ite1 (tf3 x) (tf5 (tf7 x)) Zero))
(define-fun
  mainNew
  ((x Tree)) Nat (ite1 (tf3 x) (tf9 x) Zero))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
