(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Bool2) (proj2-Cons List2))
    (Nil (proj1-Nil Unit)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Bool2)))))
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
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1) x1))))
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
(define-fun
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  tf4
  ((x Bool2) (y Nat) (z List2)) Nat
  (match z
    (((Cons tv18 tv19)
      (match x
        ((True (tf4 tv18 y tv19))
         (False (tf4 tv18 (ite1 tv18 (plus y (Succ Zero)) y) tv19)))))
     ((Nil tv17) y))))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf6
  ((x List2)) Tuple2
  (match x
    (((Cons tv26 tv27)
      (match tv26
        ((True
          (MakeTuple2
            (ite1 (snd2 (tf6 tv27))
              (fst2 (tf6 tv27)) (plus (Succ Zero) (fst2 (tf6 tv27))))
            True))
         (False (MakeTuple2 (fst2 (tf6 tv27)) False)))))
     ((Nil tv25) (MakeTuple2 Zero False)))))
(define-fun
  tf7
  ((x List2)) Nat (fst2 (tf6 x)))
(define-fun
  cnt1s
  ((x List2)) Nat (tf4 False Zero x))
(define-fun
  tf2
  ((x List2)) Nat (cnt1s (tf0 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf7 inp0)))))
(check-sat)
