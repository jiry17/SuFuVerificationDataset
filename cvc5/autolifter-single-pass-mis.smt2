(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Nat) (proj2-Cons List2))
    (Nil (proj1-Nil Unit)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf0
    ((x List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 x x)
   (match y
     (((Cons tv6 tv7) (Cons tv6 (tf0 tv7)))
      ((Nil tv5) x)))))
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
(define-funs-rec
  ((tf4
    ((x Nat) (y Nat) (z List2)) Nat)
   (tf3
    ((x Nat) (y Nat) (z List2)) Nat))
  ((match z
     (((Cons tv20 tv21) (tf3 (plus tv20 x) (max y x) tv21))
      ((Nil tv19) (max y x))))
   (tf4 y x z)))
(define-fun
  mis
  ((x List2)) Nat (tf3 Zero Zero x))
(define-fun
  tf2
  ((x List2)) Nat (mis (tf0 x)))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf6
  ((x List2)) Tuple2
  (match x
    (((Cons tv28 tv29)
      (MakeTuple2
        (ite1 (lq (fst2 (tf6 tv29)) (plus tv28 (snd2 (tf6 tv29))))
          (plus tv28 (snd2 (tf6 tv29))) (fst2 (tf6 tv29)))
        (fst2 (tf6 tv29))))
     ((Nil tv27) (MakeTuple2 Zero Zero)))))
(define-fun
  tf7
  ((x List2)) Nat (fst2 (tf6 x)))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf7 inp0)))))
(check-sat)
