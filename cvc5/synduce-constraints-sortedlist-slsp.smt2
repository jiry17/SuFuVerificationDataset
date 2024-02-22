(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Nat))
    (Concat (proj1-Concat Nat)
      (proj2-Concat CList) (proj3-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Bool2)))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Elt tv6) (Cons tv6 x))
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Single tv12) (Elt tv12))
     ((Concat tv13 tv14 tv15) (tf0 (tf3 tv14) (tf3 tv15))))))
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
  ite4
  ((x Bool2) (y CList) (z CList)) CList
  (match x
    ((True y)
     (False z))))
(define-funs-rec
  ((tf13
    ((x CList) (y CList)) CList)
   (tf12
    ((x CList)) CList))
  ((match y
     (((Single tv49) x)
      ((Concat tv50 tv51 tv52)
       (ite4 (leq tv50 Zero)
         (Concat tv50 tv51 (tf12 tv52))
         (Concat tv50 (tf12 tv51) (tf12 tv52))))))
   (tf13 x x)))
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
  tf5
  ((x CList)) Nat
  (match x
    (((Single tv23) tv23)
     ((Concat tv24 tv25 tv26) (max (tf5 tv25) (tf5 tv26))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) x y))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Single tv29) tv29)
     ((Concat tv30 tv31 tv32) (min (tf7 tv31) (tf7 tv32))))))
(define-fun-rec
  tf15
  ((x CList)) Nat
  (match x
    (((Single tv57) (max tv57 Zero))
     ((Concat tv58 tv59 tv60)
      (ite2 (leq tv58 Zero)
        (tf15 tv60) (plus (tf15 tv60) (tf15 tv59)))))))
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
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf11
  ((x List2)) Tuple3
  (match x
    (((Elt tv42) (MakeTuple3 (max Zero tv42) (geq tv42 Zero)))
     ((Cons tv43 tv44)
      (MakeTuple3
        (ite2 (and2 (geq tv43 Zero) (snd3 (tf11 tv44)))
          (plus (fst3 (tf11 tv44)) tv43) (fst3 (tf11 tv44)))
        (and2 (geq tv43 Zero) (snd3 (tf11 tv44))))))))
(define-fun
  spec
  ((x List2)) Nat (fst3 (tf11 x)))
(define-fun-rec
  tf9
  ((x CList)) Bool2
  (match x
    (((Single tv35) True)
     ((Concat tv36 tv37 tv38)
      (and2 (and2 (lq (tf5 tv37) tv36) (lq tv36 (tf7 tv38)))
        (and2 (tf9 tv37) (tf9 tv38)))))))
(define-fun
  main
  ((x CList)) Nat (ite2 (tf9 x) (spec (tf3 (tf12 x))) Zero))
(define-fun
  mainNew
  ((x CList)) Nat (ite2 (tf9 x) (tf15 x) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
