(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((IndexedList 0))
  (((Inil (proj1-Inil Unit))
    (Icons (proj1-Icons Nat)
      (proj2-Icons Nat) (proj3-Icons IndexedList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
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
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  tf7
  ((x List2)) Nat
  (match x
    (((Nil tv23) Zero)
     ((Cons tv24 tv25)
      (ite2 (lq (tf1 tv25) tv24) (plus (tf7 tv25) tv24) (tf7 tv25))))))
(define-fun-rec
  gq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero False)
     ((Succ x1)
      (match y
        ((Zero True)
         ((Succ z) (gq x1 z))))))))
(define-fun-rec
  tf5
  ((x IndexedList)) Nat
  (match x
    (((Inil tv15) Zero)
     ((Icons tv16 tv17 tv18)
      (ite2 (gq tv16 tv17) (plus tv16 (tf5 tv18)) (tf5 tv18))))))
(define-fun
  main
  ((x List2)) Nat (tf5 (tf3 x)))
(assert (not (forall ((inp0 List2)) (= (main inp0) (tf7 inp0)))))
(check-sat)
