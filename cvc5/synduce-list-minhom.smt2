(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Elt tv14) (Cons tv14 x))
      ((Cons tv15 tv16) (Cons tv15 (tf2 tv16 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Single tv20) (Elt tv20))
     ((Concat tv21 tv22) (tf2 (tf5 tv21) (tf5 tv22))))))
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
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) x y))
(define-fun-rec
  tf1
  ((x List2)) Nat
  (match x
    (((Elt tv5) tv5)
     ((Cons tv6 tv7) (min tv6 (tf1 tv7))))))
(define-fun
  main
  ((x CList)) Nat (tf1 (tf5 x)))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Single tv27) tv27)
     ((Concat tv28 tv29) (min (tf7 tv29) (tf7 tv28))))))
(assert (not (forall ((inp0 CList)) (= (main inp0) (tf7 inp0)))))
(check-sat)
