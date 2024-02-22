(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Empty (proj1-Empty Unit)) (Elt (proj1-Elt Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf10
    ((x CList) (y CList)) CList)
   (tf9
    ((x CList)) CList))
  ((match y
     (((Empty tv42) x)
      ((Elt tv43) x)
      ((Concat tv44 tv45) (Concat (tf9 tv44) (tf9 tv45)))))
   (tf10 x x)))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Nil tv6) x)
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Empty tv12) (Nil Null))
     ((Elt tv13) (Cons tv13 (Nil Null)))
     ((Concat tv14 tv15) (tf0 (tf3 tv14) (tf3 tv15))))))
(define-fun
  snd3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x1))))
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
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) x y))
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
  tf4
  ((x Nat) (y List2)) Bool2
  (match y
    (((Nil tv19) True)
     ((Cons tv20 tv21) (geq x tv20)))))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf8
  ((x List2)) Tuple3
  (match x
    (((Nil tv35) (MakeTuple3 Zero Zero))
     ((Cons tv36 tv37)
      (MakeTuple3 (max (fst3 (tf8 tv37)) tv36)
        (max (snd3 (tf8 tv37)) (min (fst3 (tf8 tv37)) tv36)))))))
(define-fun
  spec
  ((x List2)) Nat (snd3 (tf8 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf12
  ((x CList)) Tuple3
  (match x
    (((Empty tv50) (MakeTuple3 Zero Zero))
     ((Elt tv51) (MakeTuple3 Zero (max tv51 Zero)))
     ((Concat tv52 tv53)
      (MakeTuple3
        (ite2
          (and2 (lq (fst3 (tf12 tv52)) (snd3 (tf12 tv52)))
            (nateq (fst3 (tf12 tv52)) Zero))
          (snd3 (tf12 tv53))
          (ite2 (nateq (fst3 (tf12 tv52)) Zero)
            (plus (fst3 (tf12 tv52)) (fst3 (tf12 tv53))) (fst3 (tf12 tv52))))
        (max (snd3 (tf12 tv52)) (snd3 (tf12 tv53))))))))
(define-fun-rec
  tf6
  ((x List2)) Bool2
  (match x
    (((Nil tv25) True)
     ((Cons tv26 tv27) (and2 (tf4 tv26 tv27) (tf6 tv27))))))
(define-fun
  main
  ((x CList)) Nat (ite2 (tf6 (tf3 x)) (spec (tf3 (tf9 x))) Zero))
(define-fun
  mainNew
  ((x CList)) Nat (ite2 (tf6 (tf3 x)) (fst3 (tf12 x)) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
