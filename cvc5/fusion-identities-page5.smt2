(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((NList 0))
  (((Single (proj1-Single List2))
    (Ncons (proj1-Ncons List2) (proj2-Ncons NList)))))
(define-funs-rec
  ((tf6
    ((x List2)) NList)
   (tf7
    ((x List2) (y List2)) NList))
  ((tf7 x x)
   (match y
     (((Nil tv25) (Single x))
      ((Cons tv26 tv27) (Ncons x (tf6 tv27)))))))
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
  tf3
  ((x List2)) Nat
  (match x
    (((Nil tv12) Zero)
     ((Cons tv13 tv14) (plus tv13 (tf3 tv14))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun-rec
  tf5
  ((x List2)) Nat
  (match x
    (((Nil tv18) (Succ Zero))
     ((Cons tv19 tv20) (times tv19 (tf5 tv20))))))
(define-fun-rec
  tf1
  ((x NList)) List2
  (match x
    (((Single tv6) (Cons (tf5 tv6) (Nil Null)))
     ((Ncons tv7 tv8) (Cons (tf5 tv7) (tf1 tv8))))))
(define-fun
  main
  ((x List2)) Nat (tf3 (tf1 (tf6 x))))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf9
  ((x List2)) Tuple2
  (match x
    (((Nil tv32) (MakeTuple2 (Succ Zero) (Succ Zero)))
     ((Cons tv33 tv34)
      (MakeTuple2 (plus (fst2 (tf9 tv34)) (times tv33 (snd2 (tf9 tv34))))
        (times tv33 (snd2 (tf9 tv34))))))))
(define-fun
  mainNew
  ((x List2)) Nat (fst2 (tf9 x)))
(assert
  (not (forall ((inp0 List2)) (= (main inp0) (mainNew inp0)))))
(check-sat)
