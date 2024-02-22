(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat)
      (proj2-MakeTuple3 Nat) (proj3-MakeTuple3 Nat)))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 Nat) (proj2-MakeTuple4 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Cnil (proj1-Cnil Unit)) (Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun
  third3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x2))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Nil tv14) x)
      ((Cons tv15 tv16) (Cons tv15 (tf2 tv16 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Cnil tv20) (Nil Null))
     ((Single tv21) (Cons tv21 (Nil Null)))
     ((Concat tv22 tv23) (tf2 (tf5 tv22) (tf5 tv23))))))
(define-fun
  snd3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x1))))
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
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x0))))
(define-fun-rec
  tf1
  ((x List2)) Tuple3
  (match x
    (((Nil tv5) (MakeTuple3 Zero Zero Zero))
     ((Cons tv6 tv7)
      (MakeTuple3 (plus tv6 (fst3 (tf1 tv7)))
        (max Zero (plus tv6 (snd3 (tf1 tv7))))
        (max (third3 (tf1 tv7)) (plus tv6 (fst3 (tf1 tv7)))))))))
(define-fun
  spec
  ((x List2)) Tuple4 (MakeTuple4 (snd3 (tf1 x)) (third3 (tf1 x))))
(define-fun
  main
  ((x CList)) Tuple4 (spec (tf5 x)))
(define-fun-rec
  tf7
  ((x CList)) Tuple3
  (match x
    (((Cnil tv28) (MakeTuple3 Zero Zero Zero))
     ((Single tv29)
      (MakeTuple3 (max tv29 Zero) (ite2 (lq tv29 Zero) Zero tv29) tv29))
     ((Concat tv30 tv31)
      (MakeTuple3
        (max (fst3 (tf7 tv30))
          (plus (fst3 (tf7 tv31)) (third3 (tf7 tv30))))
        (ite2
          (lq (plus (third3 (tf7 tv31)) (snd3 (tf7 tv30))) (snd3 (tf7 tv31)))
          (snd3 (tf7 tv31)) (plus (third3 (tf7 tv31)) (snd3 (tf7 tv30))))
        (plus (third3 (tf7 tv31)) (third3 (tf7 tv30))))))))
(define-fun
  mainNew
  ((x CList)) Tuple4 (MakeTuple4 (fst3 (tf7 x)) (snd3 (tf7 x))))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
