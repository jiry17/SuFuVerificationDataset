(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((IndexedList 0))
  (((Inil (proj1-Inil Unit))
    (Icons (proj1-Icons Nat)
      (proj2-Icons Nat) (proj3-Icons IndexedList)))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x List2)) Nat
  (match x
    (((Nil tv3) Zero)
     ((Cons tv4 tv5) (plus (Succ Zero) (tf1 tv5))))))
(define-fun-rec
  tf3
  ((x List2)) IndexedList
  (match x
    (((Nil tv9) (Inil Null))
     ((Cons tv10 tv11) (Icons tv10 (tf1 tv11) (tf3 tv11))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun-rec
  tf5
  ((x IndexedList)) Nat
  (match x
    (((Inil tv15) Zero)
     ((Icons tv16 tv17 tv18) (plus (times tv16 tv17) (tf5 tv18))))))
(define-fun-rec
  tf7
  ((x List2)) Nat
  (match x
    (((Nil tv23) Zero)
     ((Cons tv24 tv25) (plus (tf7 tv25) (times (tf1 tv25) tv24))))))
(define-fun
  main
  ((x List2)) Nat (tf5 (tf3 x)))
(assert (not (forall ((inp0 List2)) (= (main inp0) (tf7 inp0)))))
(check-sat)
