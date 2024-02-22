(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((NList 0))
  (((Line (proj1-Line List2))
    (Ncons (proj1-Ncons List2) (proj2-Ncons NList)))))
(declare-datatypes ((CList 0))
  (((Sglt (proj1-Sglt List2))
    (Cat (proj1-Cat CList) (proj2-Cat Nat) (proj3-Cat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 Nat) (proj2-MakeTuple4 Bool2)))))
(define-funs-rec
  ((tf14
    ((x List2)) List2)
   (tf15
    ((x List2) (y List2)) List2))
  ((tf15 x x)
   (match y
     (((Elt tv54) x)
      ((Cons tv55 tv56) (Cons tv55 (tf14 tv56)))))))
(define-fun-rec
  tf1
  ((x NList) (y CList)) NList
  (match y
    (((Sglt tv5) (Ncons tv5 x))
     ((Cat tv6 tv7 tv8) (tf1 (tf1 x tv8) tv6)))))
(define-fun-rec
  tf3
  ((x CList)) NList
  (match x
    (((Sglt tv11) (Line tv11))
     ((Cat tv12 tv13 tv14) (tf1 (tf3 tv14) tv12)))))
(define-fun
  snd4
  ((x Tuple4)) Bool2 (match x (((MakeTuple4 x0 x1) x1))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf19
  ((x List2)) Nat
  (match x
    (((Elt tv67) tv67)
     ((Cons tv68 tv69) (plus (tf19 tv69) tv68)))))
(define-fun-rec
  tf5
  ((x List2)) Nat
  (match x
    (((Elt tv18) tv18)
     ((Cons tv19 tv20) (plus tv19 (tf5 tv20))))))
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
  ite5
  ((x Bool2) (y CList) (z CList)) CList
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  tf17
  ((x CList)) CList
  (match x
    (((Sglt tv59) (Sglt (tf14 tv59)))
     ((Cat tv60 tv61 tv62)
      (ite5 (leq tv61 Zero)
        (Cat tv60 tv61 (tf17 tv62)) (Cat (tf17 tv60) tv61 (tf17 tv62)))))))
(define-fun
  ite3
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite3 (lq x y) y x))
(define-fun-rec
  tf9
  ((x CList)) Nat
  (match x
    (((Sglt tv34) (tf5 tv34))
     ((Cat tv35 tv36 tv37) (max (tf9 tv35) (tf9 tv37))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite3 (lq x y) x y))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Sglt tv28) (tf5 tv28))
     ((Cat tv29 tv30 tv31) (min (tf7 tv29) (tf7 tv31))))))
(define-fun-rec
  tf21
  ((x CList)) Nat
  (match x
    (((Sglt tv72) (max (tf19 tv72) Zero))
     ((Cat tv73 tv74 tv75)
      (ite3 (leq tv74 Zero)
        (tf21 tv75) (plus (tf21 tv75) (tf21 tv73)))))))
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
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1) x0))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf11
  ((x CList)) Bool2
  (match x
    (((Sglt tv40) True)
     ((Cat tv41 tv42 tv43)
      (and2 (and2 (lq (tf9 tv41) tv42) (lq tv42 (tf7 tv43)))
        (and2 (tf11 tv41) (tf11 tv43)))))))
(define-fun
  mainNew
  ((x CList)) Nat (ite3 (tf11 x) (tf21 x) Zero))
(define-fun-rec
  tf13
  ((x NList)) Tuple4
  (match x
    (((Line tv47)
      (MakeTuple4 (max Zero (tf5 tv47)) (geq (tf5 tv47) Zero)))
     ((Ncons tv48 tv49)
      (MakeTuple4
        (ite3 (and2 (snd4 (tf13 tv49)) (geq (tf5 tv48) Zero))
          (plus (fst4 (tf13 tv49)) (tf5 tv48)) (fst4 (tf13 tv49)))
        (and2 (snd4 (tf13 tv49)) (geq (tf5 tv48) Zero)))))))
(define-fun
  spec
  ((x NList)) Nat (fst4 (tf13 x)))
(define-fun
  main
  ((x CList)) Nat (ite3 (tf11 x) (spec (tf3 (tf17 x))) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
