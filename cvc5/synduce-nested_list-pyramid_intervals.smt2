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
(declare-datatypes ((Tuple5 0))
  (((MakeTuple5 (proj1-MakeTuple5 Bool2)
      (proj2-MakeTuple5 Nat) (proj3-MakeTuple5 Nat)))))
(define-fun
  third5
  ((x Tuple5)) Nat (match x (((MakeTuple5 x0 x1 x2) x2))))
(define-fun
  third4
  ((x Tuple4)) Bool2 (match x (((MakeTuple4 x0 x1 x2) x2))))
(define-funs-rec
  ((tf4
    ((x NList)) NList)
   (tf5
    ((x NList) (y NList)) NList))
  ((tf5 x x)
   (match y
     (((Line tv20) x)
      ((Ncons tv21 tv22) (Ncons tv21 (tf4 tv22)))))))
(define-fun
  snd5
  ((x Tuple5)) Nat (match x (((MakeTuple5 x0 x1 x2) x1))))
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
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (gq x y) y x))
(define-fun
  fst5
  ((x Tuple5)) Bool2 (match x (((MakeTuple5 x0 x1 x2) x0))))
(define-fun
  fst4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1 x2) x0))))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf1
  ((x List2)) Tuple3
  (match x
    (((Elt tv7) (MakeTuple3 tv7 tv7))
     ((Cons tv8 tv9)
      (MakeTuple3 (min tv8 (fst3 (tf1 tv9)))
        (max tv8 (snd3 (tf1 tv9))))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf3
  ((x NList)) Tuple4
  (match x
    (((Line tv13)
      (MakeTuple4 (fst3 (tf1 tv13)) (snd3 (tf1 tv13)) True))
     ((Ncons tv14 tv15)
      (MakeTuple4 (min (fst4 (tf3 tv15)) (fst3 (tf1 tv14)))
        (max (snd4 (tf3 tv15)) (snd3 (tf1 tv14)))
        (and2 (third4 (tf3 tv15))
          (and2 (leq (fst4 (tf3 tv15)) (fst3 (tf1 tv14)))
            (leq (snd4 (tf3 tv15)) (snd3 (tf1 tv14))))))))))
(define-fun
  spec
  ((x NList)) Bool2 (third4 (tf3 x)))
(define-fun
  main
  ((x NList)) Bool2 (spec (tf4 x)))
(define-fun-rec
  tf7
  ((x NList)) Tuple5
  (match x
    (((Line tv27)
      (MakeTuple5 True (fst3 (tf1 tv27)) (snd3 (tf1 tv27))))
     ((Ncons tv28 tv29)
      (MakeTuple5
        (and2
          (and2 (leq (snd5 (tf7 tv29)) (fst3 (tf1 tv28))) (fst5 (tf7 tv29)))
          (leq (third5 (tf7 tv29)) (snd3 (tf1 tv28))))
        (snd5 (tf7 tv29)) (snd3 (tf1 tv28)))))))
(define-fun
  mainNew
  ((x NList)) Bool2 (fst5 (tf7 x)))
(assert
  (not (forall ((inp0 NList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
