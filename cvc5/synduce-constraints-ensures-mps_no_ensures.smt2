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
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Nil tv8) x)
      ((Cons tv6 tv7) (Cons tv6 (tf0 tv7 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Cnil tv12) (Nil Null))
     ((Single tv13) (Cons tv13 (Nil Null)))
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
  ((x Nat)) Nat (ite2 (lq Zero x) x Zero))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf5
  ((x List2)) Tuple3
  (match x
    (((Nil tv21) (MakeTuple3 Zero Zero))
     ((Cons tv22 tv23)
      (MakeTuple3 (max (plus (fst3 (tf5 tv23)) tv22))
        (plus (snd3 (tf5 tv23)) tv22))))))
(define-fun
  spec
  ((x List2)) Nat (fst3 (tf5 x)))
(define-fun
  main
  ((x CList)) Nat (spec (tf3 x)))
(define-fun-rec
  tf7
  ((x CList)) Tuple3
  (match x
    (((Cnil tv28) (MakeTuple3 Zero Zero))
     ((Single tv29) (MakeTuple3 (ite2 (lq tv29 Zero) Zero tv29) tv29))
     ((Concat tv30 tv31)
      (MakeTuple3
        (ite2
          (lq (fst3 (tf7 tv30)) (plus (snd3 (tf7 tv30)) (fst3 (tf7 tv31))))
          (plus (snd3 (tf7 tv30)) (fst3 (tf7 tv31))) (fst3 (tf7 tv30)))
        (plus (snd3 (tf7 tv30)) (snd3 (tf7 tv31))))))))
(define-fun
  mainNew
  ((x CList)) Nat (fst3 (tf7 x)))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
