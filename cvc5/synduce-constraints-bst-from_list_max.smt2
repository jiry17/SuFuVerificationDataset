(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf6
    ((x List2) (y List2)) List2)
   (tf7
    ((x List2) (y List2)) List2))
  ((tf7 y x)
   (match y
     (((Elt tv33) (Cons tv33 x))
      ((Cons tv31 tv32) (Cons tv31 (tf6 tv32 x)))))))
(define-fun-rec
  tf9
  ((x Tree)) List2
  (match x
    (((Leaf tv37) (Elt tv37))
     ((Node tv38 tv39 tv40) (tf6 (tf9 tv39) (Cons tv38 (tf9 tv40)))))))
(define-fun-rec
  tf15
  ((x Tree)) Nat
  (match x
    (((Leaf tv58) tv58)
     ((Node tv59 tv60 tv61) (tf15 tv61)))))
(define-fun-rec
  tf13
  ((x Tree)) Tree
  (match x
    (((Leaf tv50) (Leaf tv50))
     ((Node tv51 tv52 tv53) (Node tv51 tv52 (tf13 tv53))))))
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
  leq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero True)
     ((Succ x1)
      (match y
        ((Zero False)
         ((Succ z) (leq x1 z))))))))
(define-fun
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) y x))
(define-fun-rec
  tf11
  ((x List2)) Nat
  (match x
    (((Elt tv44) tv44)
     ((Cons tv45 tv46) (max tv45 (tf11 tv46))))))
(define-fun-rec
  tf3
  ((x Tree)) Nat
  (match x
    (((Leaf tv14) tv14)
     ((Node tv15 tv16 tv17) (max tv15 (max (tf3 tv16) (tf3 tv17)))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) x y))
(define-fun-rec
  tf1
  ((x Tree)) Nat
  (match x
    (((Leaf tv7) tv7)
     ((Node tv8 tv9 tv10) (min tv8 (min (tf1 tv9) (tf1 tv10)))))))
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
  tf5
  ((x Tree)) Bool2
  (match x
    (((Leaf tv21) True)
     ((Node tv22 tv23 tv24)
      (and2 (and2 (geq tv22 (tf3 tv23)) (leq tv22 (tf1 tv24)))
        (and2 (tf5 tv23) (tf5 tv24)))))))
(define-fun
  main
  ((x Tree)) Nat (ite2 (tf5 x) (tf11 (tf9 (tf13 x))) Zero))
(define-fun
  mainNew
  ((x Tree)) Nat (ite2 (tf5 x) (tf15 x) Zero))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
