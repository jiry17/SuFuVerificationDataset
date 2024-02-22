(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((List2 0))
  (((Cons (proj1-Cons Bool2) (proj2-Cons List2))
    (Nil (proj1-Nil Unit)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Bool2) (proj2-MakeTuple2 Nat)))))
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
  ite3
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  ite1
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun
  fst2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf6
  ((x List2)) Tuple2
  (match x
    (((Cons tv24 tv25)
      (match tv24
        ((True
          (MakeTuple2 (or2 (fst2 (tf6 tv25)) (nateq (snd2 (tf6 tv25)) Zero))
            (plus (Succ Zero) (snd2 (tf6 tv25)))))
         (False
          (MakeTuple2 (nateq (snd2 (tf6 tv25)) Zero) (snd2 (tf6 tv25)))))))
     ((Nil tv23) (MakeTuple2 True Zero)))))
(define-fun
  tf7
  ((x List2)) Bool2 (fst2 (tf6 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf4
  ((x Bool2) (y List2)) Bool2
  (match y
    (((Cons tv16 tv17)
      (match tv16
        ((True (ite1 x (tf4 x tv17)))
         (False (tf4 (and2 x False) tv17)))))
     ((Nil tv15) True))))
(define-fun
  zsos
  ((x List2)) Bool2 (tf4 True x))
(define-fun
  tf2
  ((x List2)) Bool2 (zsos (tf0 x)))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf7 inp0)))))
(check-sat)
