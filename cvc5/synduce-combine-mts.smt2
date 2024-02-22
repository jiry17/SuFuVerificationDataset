(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf5
  ((x List2)) List2
  (match x
    (((Nil tv18) (Nil Null))
     ((Cons tv19 tv20) (Cons tv19 (tf5 tv20))))))
(define-fun
  snd2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x1))))
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
    (((Nil tv5) Zero)
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
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite1 (lq x y) y x))
(define-fun-rec
  tf3
  ((x List2)) Nat
  (match x
    (((Nil tv11) Zero)
     ((Cons tv12 tv13) (max (plus tv12 (tf1 tv13)) (tf3 tv13))))))
(define-fun
  main
  ((x List2)) Nat (tf3 (tf5 x)))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x List2)) Tuple2
  (match x
    (((Nil tv25) (MakeTuple2 Zero Zero))
     ((Cons tv26 tv27)
      (MakeTuple2 (max (fst2 (tf7 tv27)) (plus tv26 (snd2 (tf7 tv27))))
        (plus tv26 (snd2 (tf7 tv27))))))))
(define-fun
  mainNew
  ((x List2)) Nat (fst2 (tf7 x)))
(assert
  (not (forall ((inp0 List2)) (= (main inp0) (mainNew inp0)))))
(check-sat)
