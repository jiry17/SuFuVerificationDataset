(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Bool2))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Bool2))
    (Cons (proj1-Cons Bool2) (proj2-Cons List2)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Bool2)
      (proj2-MakeTuple2 Bool2) (proj3-MakeTuple2 Bool2)))))
(define-fun
  third2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x2))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Elt tv6) (Cons tv6 x))
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Single tv12) (Elt tv12))
     ((Concat tv13 tv14) (tf0 (tf3 tv13) (tf3 tv14))))))
(define-fun
  snd2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x1))))
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
  fst2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x0))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf5
  ((x List2)) Tuple2
  (match x
    (((Elt tv18) (MakeTuple2 tv18 True tv18))
     ((Cons tv19 tv20)
      (match tv19
        ((True
          (MakeTuple2 (fst2 (tf5 tv20))
            (and2 (snd2 (tf5 tv20)) (fst2 (tf5 tv20))) (third2 (tf5 tv20))))
         (False
          (MakeTuple2 (and2 (fst2 (tf5 tv20)) False)
            (and2 (snd2 (tf5 tv20)) (or2 (fst2 (tf5 tv20)) True))
            (third2 (tf5 tv20))))))))))
(define-fun
  spec
  ((x List2)) Bool2 (snd2 (tf5 x)))
(define-fun
  main
  ((x CList)) Bool2 (spec (tf3 x)))
(define-fun-rec
  tf7
  ((x CList)) Tuple2
  (match x
    (((Single tv25) (MakeTuple2 True tv25 tv25))
     ((Concat tv26 tv27)
      (match (third2 (tf7 tv26))
        ((True
          (MakeTuple2
            (and2 (and2 (fst2 (tf7 tv26)) (fst2 (tf7 tv27))) (snd2 (tf7 tv27)))
            (snd2 (tf7 tv26)) (third2 (tf7 tv27))))
         (False
          (MakeTuple2
            (or2 (and2 (fst2 (tf7 tv26)) (fst2 (tf7 tv27)))
              (and2 (and2 (fst2 (tf7 tv26)) (fst2 (tf7 tv27)))
                (snd2 (tf7 tv27))))
            (snd2 (tf7 tv26)) (third2 (tf7 tv27))))))))))
(define-fun
  mainNew
  ((x CList)) Bool2 (fst2 (tf7 x)))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
