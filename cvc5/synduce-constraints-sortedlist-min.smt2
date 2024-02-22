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
  leq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero True)
     ((Succ x1)
      (match y
        ((Zero False)
         ((Succ z) (leq x1 z))))))))
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
  min
  ((x Nat) (y Nat)) Nat (ite1 (gq x y) y x))
(define-fun-rec
  tf5
  ((x List2)) Nat
  (match x
    (((Elt tv17) tv17)
     ((Cons tv18 tv19) (min tv18 (tf5 tv19))))))
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
    (((Elt tv5) (leq x tv5))
     ((Cons tv6 tv7) (and2 (leq x tv6) (tf1 tv6 tv7))))))
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
