(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((BoolList 0))
  (((Bnil (proj1-Bnil Unit))
    (Bcons (proj1-Bcons Bool2) (proj2-Bcons BoolList)))))
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
(define-fun-rec
  geq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero
      (match y
        ((Zero True)
         ((Succ z) False))))
     ((Succ x2)
      (match y
        ((Zero True)
         ((Succ y2) (geq x2 y2))))))))
(define-fun
  p
  ((x Nat)) Bool2 (geq Zero x))
(define-fun-rec
  tf1
  ((x List2)) BoolList
  (match x
    (((Nil tv6) (Bnil Null))
     ((Cons tv7 tv8) (Bcons (p tv7) (tf1 tv8))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf3
  ((x BoolList)) Bool2
  (match x
    (((Bnil tv13) True)
     ((Bcons tv14 tv15) (and2 tv14 (tf3 tv15))))))
(define-fun
  main
  ((x List2)) Bool2 (tf3 (tf1 x)))
(define-fun-rec
  tf5
  ((x List2)) Bool2
  (match x
    (((Nil tv21) True)
     ((Cons tv22 tv23) (and2 (tf5 tv23) (lq tv22 (Succ Zero)))))))
(assert (not (forall ((inp0 List2)) (= (main inp0) (tf5 inp0)))))
(check-sat)
