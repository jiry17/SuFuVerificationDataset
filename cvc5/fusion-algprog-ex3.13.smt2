(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((PList 0))
  (((Pnil (proj1-Pnil Unit))
    (Pcons (proj1-Pcons Nat) (proj2-Pcons Nat) (proj3-Pcons PList)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Nat) (proj2-MakeTuple2 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
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
  ((x PList)) PList
  (match x
    (((Pnil tv8) (Pnil Null))
     ((Pcons tv9 tv10 tv11)
      (Pcons (plus tv9 (Succ Zero)) tv10 (tf3 tv11))))))
(define-fun-rec
  tf1
  ((x List2)) PList
  (match x
    (((Nil tv3) (Pnil Null))
     ((Cons tv4 tv5) (Pcons Zero tv4 (tf3 (tf1 tv5)))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun-rec
  tf5
  ((x PList)) Nat
  (match x
    (((Pnil tv15) Zero)
     ((Pcons tv16 tv17 tv18) (plus (times tv16 tv17) (tf5 tv18))))))
(define-fun
  main
  ((x List2)) Nat (tf5 (tf1 x)))
(define-fun
  fst2
  ((x Tuple2)) Nat (match x (((MakeTuple2 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x List2)) Tuple2
  (match x
    (((Nil tv23) (MakeTuple2 Zero Zero))
     ((Cons tv24 tv25)
      (MakeTuple2 (plus (fst2 (tf7 tv25)) (snd2 (tf7 tv25)))
        (plus (snd2 (tf7 tv25)) tv24))))))
(define-fun
  mainNew
  ((x List2)) Nat (fst2 (tf7 x)))
(assert
  (not (forall ((inp0 List2)) (= (main inp0) (mainNew inp0)))))
(check-sat)
