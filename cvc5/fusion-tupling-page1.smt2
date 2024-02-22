(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Tree) (proj2-Node Tree)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 List2) (proj2-MakeTuple3 Tree)))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 List2) (proj2-MakeTuple4 Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Nil tv6) x)
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun
  snd4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1) x1))))
(define-fun
  snd3
  ((x Tuple3)) Tree (match x (((MakeTuple3 x0 x1) x1))))
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
  ite4
  ((x Bool2) (y Tuple4) (z Tuple4)) Tuple4
  (match x
    ((True y)
     (False z))))
(define-fun
  ite3
  ((x Bool2) (y Tuple3) (z Tuple3)) Tuple3
  (match x
    ((True y)
     (False z))))
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
  tf3
  ((x Tree)) Nat
  (match x
    (((Leaf tv14) Zero)
     ((Node tv15 tv16)
      (plus (Succ Zero) (max (tf3 tv15) (tf3 tv16)))))))
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
  fst4
  ((x Tuple4)) List2 (match x (((MakeTuple4 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x Tree)) Tuple4
  (match x
    (((Leaf tv28) (MakeTuple4 (Cons tv28 (Nil Null)) Zero))
     ((Node tv29 tv30)
      (ite4 (gq (snd4 (tf7 tv29)) (snd4 (tf7 tv30)))
        (MakeTuple4 (fst4 (tf7 tv29)) (plus (Succ Zero) (snd4 (tf7 tv29))))
        (ite4 (nateq (snd4 (tf7 tv29)) (snd4 (tf7 tv30)))
          (MakeTuple4 (tf0 (fst4 (tf7 tv29)) (fst4 (tf7 tv30)))
            (plus (snd4 (tf7 tv29)) (Succ Zero)))
          (MakeTuple4 (fst4 (tf7 tv30))
            (plus (snd4 (tf7 tv30)) (Succ Zero)))))))))
(define-fun
  mainNew
  ((x Tree)) List2 (fst4 (tf7 x)))
(define-fun
  fst3
  ((x Tuple3)) List2 (match x (((MakeTuple3 x0 x1) x0))))
(define-funs-rec
  ((tf5
    ((x Tree) (y Tree)) Tuple3)
   (tf4
    ((x Tree)) Tuple3))
  ((match y
     (((Leaf tv21) (MakeTuple3 (Cons tv21 (Nil Null)) x))
      ((Node tv22 tv23)
       (ite3 (gq (tf3 (snd3 (tf4 tv22))) (tf3 (snd3 (tf4 tv23))))
         (MakeTuple3 (fst3 (tf4 tv22)) x)
         (ite3 (nateq (tf3 (snd3 (tf4 tv22))) (tf3 (snd3 (tf4 tv23))))
           (MakeTuple3 (tf0 (fst3 (tf4 tv22)) (fst3 (tf4 tv23))) x)
           (MakeTuple3 (fst3 (tf4 tv23)) x))))))
   (tf5 x x)))
(define-fun
  main
  ((x Tree)) List2 (fst3 (tf4 x)))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
