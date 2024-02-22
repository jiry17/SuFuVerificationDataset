(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun
  tf9
  ((x Tree)) Tree x)
(define-fun
  tf8
  ((x Tree)) Tree x)
(define-fun
  target
  ((x Tree)) Tree x)
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
(define-fun-rec
  leq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero True)
     ((Succ x1)
      (match y
        ((Zero False)
         ((Succ z) (leq x1 z))))))))
(define-fun
  ite2
  ((x Bool2) (y Tuple2)) Tuple2
  (match x
    ((True y)
     (False (MakeTuple2 Zero Zero)))))
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
  tf3
  ((x Tree)) Nat
  (match x
    (((Leaf tv14) tv14)
     ((Node tv15 tv16 tv17) (max tv15 (max (tf3 tv16) (tf3 tv17)))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite1 (lq x y) x y))
(define-fun-rec
  tf1
  ((x Tree)) Nat
  (match x
    (((Leaf tv7) tv7)
     ((Node tv8 tv9 tv10) (min tv8 (min (tf1 tv9) (tf1 tv10)))))))
(define-fun
  tf11
  ((x Tree)) Tuple2
  (match x
    (((Leaf tv41) (MakeTuple2 tv41 tv41))
     ((Node tv42 tv43 tv44) (MakeTuple2 (tf3 tv44) (tf1 tv43))))))
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
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x Tree)) Tuple2
  (match x
    (((Leaf tv28) (MakeTuple2 tv28 tv28))
     ((Node tv29 tv30 tv31)
      (MakeTuple2 (max tv29 (max (fst2 (tf7 tv30)) (fst2 (tf7 tv31))))
        (min tv29 (min (snd2 (tf7 tv30)) (snd2 (tf7 tv31)))))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf5
  ((x Tree)) Bool2
  (match x
    (((Leaf tv21) True)
     ((Node tv22 tv23 tv24)
      (and2 (and2 (geq tv22 (tf3 tv23)) (leq tv22 (tf1 tv24)))
        (and2 (tf5 tv23) (tf5 tv24)))))))
(define-fun
  main
  ((x Tree)) Tuple2 (ite2 (tf5 x) (tf7 x)))
(define-fun
  mainNew
  ((x Tree)) Tuple2
  (ite2 (tf5 x) (MakeTuple2 (fst2 (tf11 x)) (snd2 (tf11 x)))))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
