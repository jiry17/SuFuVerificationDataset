(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Leaf (proj1-Leaf Nat))
    (Branch (proj1-Branch Tree) (proj2-Branch Tree)))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf3
  ((x Tree)) Nat
  (match x
    (((Leaf tv10) tv10)
     ((Branch tv11 tv12) (plus (tf3 tv11) (tf3 tv12))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun
  square
  ((x Nat)) Nat (times x x))
(define-fun-rec
  tf1
  ((x Tree)) Tree
  (match x
    (((Leaf tv4) (Leaf (square tv4)))
     ((Branch tv5 tv6) (Branch (tf1 tv5) (tf1 tv6))))))
(define-fun-rec
  tf5
  ((x Tree)) Nat
  (match x
    (((Leaf tv17) (square tv17))
     ((Branch tv18 tv19) (plus (tf5 tv18) (tf5 tv19))))))
(define-fun
  main
  ((x Tree)) Nat (tf3 (tf1 x)))
(assert (not (forall ((inp0 Tree)) (= (main inp0) (tf5 inp0)))))
(check-sat)
