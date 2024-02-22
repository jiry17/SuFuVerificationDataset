(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Single tv25) tv25)
     ((Concat tv26 tv27) (tf7 tv27)))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Elt tv12) (Cons tv12 x))
      ((Cons tv13 tv14) (Cons tv13 (tf2 tv14 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Single tv18) (Elt tv18))
     ((Concat tv19 tv20) (tf2 (tf5 tv19) (tf5 tv20))))))
(define-fun-rec
  tf1
  ((x List2)) Nat
  (match x
    (((Elt tv3) tv3)
     ((Cons tv4 tv5) (tf1 tv5)))))
(define-fun
  main
  ((x CList)) Nat (tf1 (tf5 x)))
(assert (not (forall ((inp0 CList)) (= (main inp0) (tf7 inp0)))))
(check-sat)
