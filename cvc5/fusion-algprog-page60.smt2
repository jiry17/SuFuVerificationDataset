(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Tip (proj1-Tip Nat)) (Bin (proj1-Bin Tree) (proj2-Bin Tree)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun
  op
  ((x Nat)) Nat (plus (Succ Zero) x))
(define-fun-rec
  tf3
  ((x Tree)) Tree
  (match x
    (((Tip tv13) (Tip (op tv13)))
     ((Bin tv14 tv15) (Bin (tf3 tv14) (tf3 tv15))))))
(define-fun-rec
  tf1
  ((x Tree)) Tree
  (match x
    (((Tip tv6) (Tip Zero))
     ((Bin tv7 tv8) (Bin (tf3 (tf1 tv7)) (tf3 (tf1 tv8)))))))
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
  ((x Tree)) Nat
  (match x
    (((Tip tv22) tv22)
     ((Bin tv23 tv24) (max (tf5 tv23) (tf5 tv24))))))
(define-fun
  main
  ((x Tree)) Nat (tf5 (tf1 x)))
(define-fun-rec
  tf7
  ((x Tree)) Nat
  (match x
    (((Tip tv30) Zero)
     ((Bin tv31 tv32)
      (ite1 (lq (tf7 tv31) (tf7 tv32))
        (plus (Succ Zero) (tf7 tv32)) (plus (Succ Zero) (tf7 tv31)))))))
(assert (not (forall ((inp0 Tree)) (= (main inp0) (tf7 inp0)))))
(check-sat)
