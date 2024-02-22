(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Single (proj1-Single Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Elt (proj1-Elt Nat))
    (Cat (proj1-Cat CList) (proj2-Cat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat)
      (proj2-MakeTuple3 Nat) (proj3-MakeTuple3 Bool2)))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 Bool2) (proj2-MakeTuple4 Nat)))))
(define-fun
  third3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1 x2) x2))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Single tv14) (Cons tv14 x))
      ((Cons tv15 tv16) (Cons tv15 (tf2 tv16 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Elt tv20) (Single tv20))
     ((Cat tv21 tv22) (tf2 (tf5 tv21) (tf5 tv22))))))
(define-fun
  snd4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1) x1))))
(define-fun
  snd3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x1))))
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
(define-fun-rec
  gq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero False)
     ((Succ x1)
      (match y
        ((Zero True)
         ((Succ z) (gq x1 z))))))))
(define-fun-rec
  tf1
  ((x List2)) Tuple3
  (match x
    (((Single tv5) (MakeTuple3 tv5 tv5 True))
     ((Cons tv6 tv7)
      (MakeTuple3 tv6
        (max (snd3 (tf1 tv7)) tv6) (gq tv6 (snd3 (tf1 tv7))))))))
(define-fun
  spec
  ((x List2)) Bool2 (third3 (tf1 x)))
(define-fun
  main
  ((x CList)) Bool2 (spec (tf5 x)))
(define-fun
  fst4
  ((x Tuple4)) Bool2 (match x (((MakeTuple4 x0 x1) x0))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf7
  ((x CList)) Tuple4
  (match x
    (((Elt tv27) (MakeTuple4 True tv27))
     ((Cat tv28 tv29)
      (MakeTuple4
        (and2 (fst4 (tf7 tv28)) (lq (snd4 (tf7 tv29)) (snd4 (tf7 tv28))))
        (max (snd4 (tf7 tv29)) (snd4 (tf7 tv28))))))))
(define-fun
  mainNew
  ((x CList)) Bool2 (fst4 (tf7 x)))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
