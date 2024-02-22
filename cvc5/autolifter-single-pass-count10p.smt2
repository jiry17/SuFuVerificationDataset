(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Bool2) (proj2-Cons List2))
    (Nil (proj1-Nil Unit)))))
(define-fun
  tf5
  ((x List2)) Bool2
  (match x
    (((Cons tv23 tv24) tv23)
     ((Nil tv22) False))))
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
(define-fun
  or2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True True)
     (False y))))
(define-fun
  not2
  ((x Bool2)) Bool2
  (match x
    ((True False)
     (False True))))
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
(define-fun
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x List2)) Tuple2
  (match x
    (((Cons tv30 tv31)
      (match tv30
        ((True
          (MakeTuple2
            (ite1 (or2 (nateq (fst2 (tf7 tv31)) (snd2 (tf7 tv31))) (tf5 tv31))
              (fst2 (tf7 tv31)) (plus (Succ Zero) (fst2 (tf7 tv31))))
            (plus (Succ Zero) (snd2 (tf7 tv31)))))
         (False (MakeTuple2 (fst2 (tf7 tv31)) (snd2 (tf7 tv31)))))))
     ((Nil tv29) (MakeTuple2 Zero Zero)))))
(define-fun
  tf8
  ((x List2)) Nat (fst2 (tf7 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf4
  ((x Bool2) (y Bool2) (z List2)) Nat
  (match z
    (((Cons tv18 tv19)
      (match tv18
        ((True (plus (ite1 y (Succ Zero) Zero) (tf4 True False tv19)))
         (False
          (plus (ite1 (and2 y False) (Succ Zero) Zero)
            (tf4 False (or2 x y) tv19))))))
     ((Nil tv17) Zero))))
(define-fun
  count10p
  ((x List2)) Nat (tf4 False False x))
(define-fun
  tf2
  ((x List2)) Nat (count10p (tf0 x)))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf8 inp0)))))
(check-sat)
