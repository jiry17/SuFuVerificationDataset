(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Bool2) (proj2-Cons List2)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Bool2) (proj2-MakeTuple2 Bool2)))))
(define-funs-rec
  ((tf0
    ((x List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 x x)
   (match y
     (((Nil tv5) x)
      ((Cons tv6 tv7) (Cons tv6 (tf0 tv7)))))))
(define-fun
  snd2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1) x1))))
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
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True True)
     (False y))))
(define-fun
  fst2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1) x0))))
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
    (((Nil tv15) False)
     ((Cons tv16 tv17)
      (match tv16
        ((True (ite1 (and2 x False) (tf4 (or2 x True) tv17)))
         (False
          (match x
            ((True True)
             (False (tf4 False tv17)))))))))))
(define-fun
  zafter1
  ((x List2)) Bool2 (tf4 False x))
(define-fun
  tf2
  ((x List2)) Bool2 (zafter1 (tf0 x)))
(define-fun-rec
  tf6
  ((x List2)) Tuple2
  (match x
    (((Nil tv23) (MakeTuple2 False True))
     ((Cons tv24 tv25)
      (match (snd2 (tf6 tv25))
        ((True
          (MakeTuple2 (or2 (and2 tv24 False) (fst2 (tf6 tv25)))
            (and2 tv24 (snd2 (tf6 tv25)))))
         (False
          (MakeTuple2 (or2 tv24 (fst2 (tf6 tv25)))
            (and2 tv24 (snd2 (tf6 tv25)))))))))))
(define-fun
  tf7
  ((x List2)) Bool2 (fst2 (tf6 x)))
(assert (not (forall ((inp0 List2)) (= (tf2 inp0) (tf7 inp0)))))
(check-sat)
