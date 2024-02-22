(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat)
      (proj2-MakeTuple3 Nat) (proj3-MakeTuple3 Nat)))))
(declare-datatypes ((Tuple4 0))
  (((MakeTuple4 (proj1-MakeTuple4 Nat) (proj2-MakeTuple4 Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((IdxList 0))
  (((Ielt (proj1-Ielt Nat))
    (Icons (proj1-Icons Nat)
      (proj2-Icons Nat) (proj3-Icons IdxList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun
  third3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x2))))
(define-fun-rec
  tf5
  ((x IdxList)) List2
  (match x
    (((Ielt tv18) (Elt tv18))
     ((Icons tv19 tv20 tv21) (Cons tv19 (tf5 tv21))))))
(define-fun
  snd4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1) x1))))
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
  tf1
  ((x List2)) Nat
  (match x
    (((Elt tv5) tv5)
     ((Cons tv6 tv7) (plus tv6 (tf1 tv7))))))
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
  ite3
  ((x Bool2) (y Tuple3)) Tuple3
  (match x
    ((True y)
     (False (MakeTuple3 Zero Zero Zero)))))
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
  fst4
  ((x Tuple4)) Nat (match x (((MakeTuple4 x0 x1) x0))))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x0))))
(define-fun-rec
  tf3
  ((x List2)) Tuple3
  (match x
    (((Elt tv11) (ite3 (gq tv11 Zero) (MakeTuple3 tv11 tv11 tv11)))
     ((Cons tv12 tv13)
      (MakeTuple3 (max (plus tv12 (tf1 tv13)) (fst3 (tf3 tv13)))
        (max (plus tv12 (snd3 (tf3 tv13))) Zero)
        (max (max (plus tv12 (snd3 (tf3 tv13))) Zero)
          (third3 (tf3 tv13))))))))
(define-fun
  mss
  ((x List2)) Nat (third3 (tf3 x)))
(define-fun
  main
  ((x IdxList)) Nat (mss (tf5 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf7
  ((x IdxList)) Tuple4
  (match x
    (((Ielt tv26) (MakeTuple4 (max tv26 Zero) tv26))
     ((Icons tv27 tv28 tv29)
      (MakeTuple4
        (ite2
          (and2 (lq (plus tv27 (snd4 (tf7 tv29))) (fst4 (tf7 tv29)))
            (lq tv27 (fst4 (tf7 tv29))))
          (fst4 (tf7 tv29))
          (ite2 (lq (snd4 (tf7 tv29)) Zero)
            tv27 (plus tv27 (snd4 (tf7 tv29)))))
        (plus tv27 (max (snd4 (tf7 tv29)) Zero)))))))
(define-fun
  mainNew
  ((x IdxList)) Nat (fst4 (tf7 x)))
(assert
  (not (forall ((inp0 IdxList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
