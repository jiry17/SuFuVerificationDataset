(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((SList 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons SList)))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat)
      (proj2-MakeTuple2 Nat) (proj3-MakeTuple2 Bool2)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Bool2)
      (proj2-MakeTuple3 Nat) (proj3-MakeTuple3 Nat)))))
(define-fun
  third3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x2))))
(define-fun
  third2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x2))))
(define-funs-rec
  ((tf0
    ((x SList) (y SList)) SList)
   (tf1
    ((x SList) (y SList)) SList))
  ((tf1 y x)
   (match y
     (((Elt tv6) (Cons tv6 x))
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun-rec
  tf3
  ((x CList)) SList
  (match x
    (((Single tv12) (Elt tv12))
     ((Concat tv13 tv14) (tf0 (tf3 tv13) (tf3 tv14))))))
(define-fun
  snd3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1 x2) x1))))
(define-fun
  snd2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1 x2) x1))))
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
  fst3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1 x2) x0))))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1 x2) x0))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf5
  ((x SList)) Tuple2
  (match x
    (((Elt tv18) (MakeTuple2 tv18 tv18 True))
     ((Cons tv19 tv20)
      (MakeTuple2 tv19
        (snd2 (tf5 tv20))
        (and2 (third2 (tf5 tv20)) (lq tv19 (fst2 (tf5 tv20)))))))))
(define-fun
  spec
  ((x SList)) Bool2 (third2 (tf5 x)))
(define-fun
  main
  ((x CList)) Bool2 (spec (tf3 x)))
(define-fun-rec
  tf7
  ((x CList)) Tuple3
  (match x
    (((Single tv25) (MakeTuple3 True tv25 tv25))
     ((Concat tv26 tv27)
      (MakeTuple3
        (and2 (and2 (fst3 (tf7 tv26)) (fst3 (tf7 tv27)))
          (lq (third3 (tf7 tv26)) (snd3 (tf7 tv27))))
        (snd3 (tf7 tv26)) (third3 (tf7 tv27)))))))
(define-fun
  mainNew
  ((x CList)) Bool2 (fst3 (tf7 x)))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
