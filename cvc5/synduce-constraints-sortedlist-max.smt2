(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun
  tf9
  ((x List2)) Nat
  (match x
    (((Elt tv29) tv29)
     ((Cons tv30 tv31) tv30))))
(define-fun
  tf7
  ((x List2) (y List2)) List2
  (match y
    (((Elt tv23) x)
     ((Cons tv24 tv25) x))))
(define-fun
  tf6
  ((x List2)) List2 x)
(define-fun
  target
  ((x List2)) List2 x)
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
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite1 (lq x y) y x))
(define-fun-rec
  tf5
  ((x List2)) Nat
  (match x
    (((Elt tv17) tv17)
     ((Cons tv18 tv19) (max tv18 (tf5 tv19))))))
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
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf1
  ((x Nat) (y List2)) Bool2
  (match y
    (((Elt tv5) (geq x tv5))
     ((Cons tv6 tv7) (and2 (geq x tv6) (tf1 tv6 tv7))))))
(define-fun
  tf3
  ((x List2)) Bool2
  (match x
    (((Elt tv9) True)
     ((Cons tv10 tv11) (tf1 tv10 tv11)))))
(define-fun
  main
  ((x List2)) Nat (ite1 (tf3 x) (tf5 x) Zero))
(define-fun
  mainNew
  ((x List2)) Nat (ite1 (tf3 x) (tf9 x) Zero))
(assert
  (not (forall ((inp0 List2)) (= (main inp0) (mainNew inp0)))))
(check-sat)
