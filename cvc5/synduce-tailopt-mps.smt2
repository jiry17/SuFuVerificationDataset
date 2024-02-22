(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf2
    ((x List2) (y Nat)) List2)
   (tf3
    ((x Nat) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Nil tv14) (Cons x (Nil Null)))
      ((Cons tv15 tv16) (Cons tv15 (tf2 tv16 x)))))))
(define-fun-rec
  tf5
  ((x List2) (y List2)) List2
  (match y
    (((Nil tv22) x)
     ((Cons tv23 tv24) (tf5 (tf2 x tv23) tv24)))))
(define-fun
  snd2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x1))))
(define-fun
  repr
  ((x List2)) List2 (tf5 (Nil Null) x))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
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
  max
  ((x Nat) (y Nat)) Nat (ite1 (gq x y) x y))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf1
  ((x List2)) Tuple2
  (match x
    (((Nil tv5) (MakeTuple2 Zero Zero))
     ((Cons tv6 tv7)
      (MakeTuple2 (plus tv6 (fst2 (tf1 tv7)))
        (max Zero (plus tv6 (snd2 (tf1 tv7)))))))))
(define-fun
  spec
  ((x List2)) Nat (snd2 (tf1 x)))
(define-fun
  main
  ((x List2)) Nat (spec (repr x)))
(define-fun-rec
  tf7
  ((x Tuple2) (y List2)) Tuple2
  (match y
    (((Nil tv31) x)
     ((Cons tv32 tv33)
      (tf7
        (MakeTuple2 (max (fst2 x) (plus tv32 (snd2 x)))
          (plus tv32 (snd2 x)))
        tv33)))))
(define-fun
  reprNew
  ((x List2)) Tuple2 (tf7 (MakeTuple2 Zero Zero) x))
(define-fun
  mainNew
  ((x List2)) Nat (fst2 (reprNew x)))
(assert
  (not (forall ((inp0 List2)) (= (main inp0) (mainNew inp0)))))
(check-sat)
