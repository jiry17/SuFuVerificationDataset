(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Elt tv14) (Cons tv14 x))
      ((Cons tv15 tv16) (Cons tv15 (tf2 tv16 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Single tv20) (Elt tv20))
     ((Concat tv21 tv22) (tf2 (tf5 tv21) (tf5 tv22))))))
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
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf1
  ((x List2)) Tuple3
  (match x
    (((Elt tv5) (MakeTuple3 tv5 (Succ Zero)))
     ((Cons tv6 tv7)
      (MakeTuple3 (min (fst3 (tf1 tv7)) tv6)
        (ite2 (lq tv6 (fst3 (tf1 tv7)))
          (Succ Zero)
          (plus (snd3 (tf1 tv7))
            (ite2 (nateq tv6 (fst3 (tf1 tv7))) (Succ Zero) Zero))))))))
(define-fun
  spec
  ((x List2)) Nat (snd3 (tf1 x)))
(define-fun
  main
  ((x CList)) Nat (spec (tf5 x)))
(define-fun-rec
  tf7
  ((x CList)) Tuple3
  (match x
    (((Single tv27) (MakeTuple3 (Succ Zero) tv27))
     ((Concat tv28 tv29)
      (MakeTuple3
        (ite2 (lq (snd3 (tf7 tv28)) (snd3 (tf7 tv29)))
          (fst3 (tf7 tv28))
          (ite2 (nateq (snd3 (tf7 tv29)) (snd3 (tf7 tv28)))
            (plus (fst3 (tf7 tv29)) (fst3 (tf7 tv28))) (fst3 (tf7 tv29))))
        (min (snd3 (tf7 tv29)) (snd3 (tf7 tv28))))))))
(define-fun
  mainNew
  ((x CList)) Nat (fst3 (tf7 x)))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
