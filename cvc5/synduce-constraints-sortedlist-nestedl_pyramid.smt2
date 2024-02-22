(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((NList 0))
  (((Line (proj1-Line List2))
    (Ncons (proj1-Ncons List2) (proj2-Ncons NList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 Nat)
      (proj2-MakeTuple4 Nat) (proj3-MakeTuple4 Bool2)))))
(declare-datatypes ((Tuple6 0))
  (((MakeTuple6 (proj1-MakeTuple6 Bool2) (proj2-MakeTuple6 Nat)))))
(define-fun
  third4
  ((x Tuple4)) Bool2 (match x (((MakeTuple4 x0 x1 x2) x2))))
(define-funs-rec
  ((tf12
    ((x NList)) NList)
   (tf13
    ((x NList) (y NList)) NList))
  ((tf13 x x)
   (match y
     (((Line tv44) x)
      ((Ncons tv45 tv46) (Ncons tv45 (tf12 tv46)))))))
(define-fun
  snd6
  ((x Tuple6)) Nat (match x (((MakeTuple6 x0 x1) x1))))
(define-fun
  snd4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2) x1))))
(define-fun
  snd3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x1))))
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
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
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
  tf1
  ((x List2)) Nat
  (match x
    (((Elt tv5) tv5)
     ((Cons tv6 tv7) (max tv6 (tf1 tv7))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) x y))
(define-fun-rec
  tf3
  ((x List2)) Nat
  (match x
    (((Elt tv13) tv13)
     ((Cons tv14 tv15) (min tv14 (tf3 tv15))))))
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
  fst6
  ((x Tuple6)) Bool2 (match x (((MakeTuple6 x0 x1) x0))))
(define-fun
  fst4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2) x0))))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf9
  ((x List2)) Tuple3
  (match x
    (((Elt tv31) (MakeTuple3 tv31 tv31))
     ((Cons tv32 tv33)
      (MakeTuple3 (min (fst3 (tf9 tv33)) tv32)
        (max (snd3 (tf9 tv33)) tv32))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf11
  ((x NList)) Tuple4
  (match x
    (((Line tv37)
      (MakeTuple4 (fst3 (tf9 tv37)) (snd3 (tf9 tv37)) True))
     ((Ncons tv38 tv39)
      (MakeTuple4 (min (fst3 (tf9 tv38)) (fst4 (tf11 tv39)))
        (max (snd3 (tf9 tv38)) (snd4 (tf11 tv39)))
        (and2 (third4 (tf11 tv39))
          (and2 (leq (fst4 (tf11 tv39)) (fst3 (tf9 tv38)))
            (geq (snd4 (tf11 tv39)) (snd3 (tf9 tv38))))))))))
(define-fun
  spec
  ((x NList)) Bool2 (third4 (tf11 x)))
(define-fun-rec
  tf15
  ((x NList)) Tuple6
  (match x
    (((Line tv51) (MakeTuple6 True (fst3 (tf9 tv51))))
     ((Ncons tv52 tv53)
      (MakeTuple6
        (and2 (fst6 (tf15 tv53)) (leq (snd6 (tf15 tv53)) (tf3 tv52)))
        (snd6 (tf15 tv53)))))))
(define-fun-rec
  tf5
  ((x Nat) (y NList)) Bool2
  (match y
    (((Line tv21) (leq x (tf1 tv21)))
     ((Ncons tv22 tv23)
      (and2 (leq x (tf1 tv22)) (tf5 (tf1 tv22) tv23))))))
(define-fun
  tf7
  ((x NList)) Bool2
  (match x
    (((Line tv25) True)
     ((Ncons tv26 tv27) (tf5 (tf1 tv26) tv27)))))
(define-fun
  main
  ((x NList)) Bool2 (ite5 (tf7 x) (spec (tf12 x))))
(define-fun
  mainNew
  ((x NList)) Bool2 (ite5 (tf7 x) (fst6 (tf15 x))))
(assert
  (not (forall ((inp0 NList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
