(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 Nat)
      (proj2-MakeTuple4 Nat) (proj3-MakeTuple4 Nat)
      (proj4-MakeTuple4 Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CnList 0))
  (((Sglt (proj1-Sglt Nat))
    (Cat (proj1-Cat CnList) (proj2-Cat Nat) (proj3-Cat CnList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Bool2)))))
(define-fun
  third4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2 x3) x2))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Elt tv8) (Cons tv8 x))
      ((Cons tv9 tv10) (Cons tv9 (tf0 tv10 x)))))))
(define-fun-rec
  tf3
  ((x CnList)) List2
  (match x
    (((Sglt tv14) (Elt tv14))
     ((Cat tv15 tv16 tv17) (tf0 (tf3 tv15) (tf3 tv17))))))
(define-fun
  snd4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2 x3) x1))))
(define-fun
  snd3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1) x1))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun
  or2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True True)
     (False y))))
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
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
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
  max
  ((x Nat) (y Nat)) Nat (ite2 (gq x y) x y))
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
  fst4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2 x3) x0))))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun
  fourth4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2 x3) x3))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf5
  ((x List2)) Tuple3
  (match x
    (((Elt tv21) (MakeTuple3 (max Zero tv21) (geq tv21 Zero)))
     ((Cons tv22 tv23)
      (MakeTuple3
        (ite2 (and2 (snd3 (tf5 tv23)) (geq tv22 Zero))
          (plus tv22 (fst3 (tf5 tv23))) (fst3 (tf5 tv23)))
        (and2 (snd3 (tf5 tv23)) (geq tv22 Zero)))))))
(define-fun
  spec
  ((x List2)) Nat (fst3 (tf5 x)))
(define-fun
  main
  ((x CnList)) Nat (spec (tf3 x)))
(define-fun-rec
  tf7
  ((x CnList)) Tuple4
  (match x
    (((Sglt tv28)
      (MakeTuple4 (max tv28 Zero)
        (times (Succ (Succ Zero)) (max tv28 Zero)) tv28 tv28))
     ((Cat tv29 tv30 tv31)
      (MakeTuple4
        (ite2
          (or2
            (and2 (nateq (fourth4 (tf7 tv31)) Zero)
              (nateq (fst4 (tf7 tv31)) (third4 (tf7 tv31))))
            (lq (fst4 (tf7 tv31)) (snd4 (tf7 tv31))))
          (plus (fst4 (tf7 tv31)) (fst4 (tf7 tv29))) (fst4 (tf7 tv31)))
        (ite2
          (or2
            (or2
              (and2 (lq (fst4 (tf7 tv31)) (snd4 (tf7 tv31)))
                (lq (fst4 (tf7 tv29)) (snd4 (tf7 tv29))))
              (and2 (nateq (fourth4 (tf7 tv31)) Zero)
                (nateq (fst4 (tf7 tv31)) (third4 (tf7 tv31)))))
            (and2 (nateq (fourth4 (tf7 tv29)) Zero)
              (nateq (fst4 (tf7 tv29)) (third4 (tf7 tv29)))))
          (plus (snd4 (tf7 tv31)) (snd4 (tf7 tv29)))
          (ite2
            (or2
              (and2 (lq Zero (fourth4 (tf7 tv31)))
                (nateq (fst4 (tf7 tv31)) (snd4 (tf7 tv31))))
              (lq (third4 (tf7 tv31)) (fst4 (tf7 tv31))))
            (fst4 (tf7 tv31)) (plus (fst4 (tf7 tv31)) (fst4 (tf7 tv29)))))
        (plus (third4 (tf7 tv31)) (third4 (tf7 tv29)))
        (max (fourth4 (tf7 tv31)) (fourth4 (tf7 tv29))))))))
(define-fun
  mainNew
  ((x CnList)) Nat (fst4 (tf7 x)))
(assert
  (not (forall ((inp0 CnList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
