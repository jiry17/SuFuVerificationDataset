(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Cnil (proj1-Cnil Unit)) (Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf9
  ((x CList)) CList
  (match x
    (((Cnil tv36) (Cnil Null))
     ((Single tv37) (Single tv37))
     ((Concat tv38 tv39) (Concat (tf9 tv38) (tf9 tv39))))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Nil tv15) x)
      ((Cons tv13 tv14) (Cons tv13 (tf2 tv14 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Cnil tv19) (Nil Null))
     ((Single tv20) (Cons tv20 (Nil Null)))
     ((Concat tv21 tv22) (tf2 (tf5 tv21) (tf5 tv22))))))
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
(define-fun
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) y x))
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
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x List2)) Tuple3
  (match x
    (((Nil tv30) (MakeTuple3 Zero Zero))
     ((Cons tv31 tv32)
      (MakeTuple3 (max tv31 (fst3 (tf7 tv32)))
        (max (snd3 (tf7 tv32)) (min (fst3 (tf7 tv32)) tv31)))))))
(define-fun
  spec
  ((x List2)) Nat (snd3 (tf7 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf1
  ((x CList)) Bool2
  (match x
    (((Cnil tv3) True)
     ((Single tv4) (gq tv4 Zero))
     ((Concat tv5 tv6) (and2 (tf1 tv5) (tf1 tv6))))))
(define-fun
  main
  ((x CList)) Nat (ite2 (tf1 x) (spec (tf5 (tf9 x))) Zero))
(define-fun-rec
  tf11
  ((x CList)) Tuple3
  (match x
    (((Cnil tv44) (MakeTuple3 Zero Zero))
     ((Single tv45) (MakeTuple3 Zero tv45))
     ((Concat tv46 tv47)
      (MakeTuple3
        (ite2
          (and2 (lq (snd3 (tf11 tv47)) (snd3 (tf11 tv46)))
            (lq (fst3 (tf11 tv46)) (snd3 (tf11 tv47))))
          (snd3 (tf11 tv47))
          (ite2 (lq (snd3 (tf11 tv46)) (fst3 (tf11 tv47)))
            (fst3 (tf11 tv47))
            (ite2 (lq (snd3 (tf11 tv47)) (snd3 (tf11 tv46)))
              (fst3 (tf11 tv46)) (snd3 (tf11 tv46)))))
        (max (snd3 (tf11 tv46)) (snd3 (tf11 tv47))))))))
(define-fun
  mainNew
  ((x CList)) Nat (ite2 (tf1 x) (fst3 (tf11 x)) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
