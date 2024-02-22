(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf15
  ((x CList)) Nat
  (match x
    (((Single tv54) tv54)
     ((Concat tv55 tv56) (tf15 tv55)))))
(define-funs-rec
  ((tf12
    ((x CList)) CList)
   (tf13
    ((x CList) (y CList)) CList))
  ((tf13 x x)
   (match y
     (((Single tv47) x)
      ((Concat tv48 tv49) (Concat (tf12 tv48) tv49))))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Elt tv6) (Cons tv6 x))
      ((Cons tv7 tv8) (Cons tv7 (tf0 tv8 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Single tv12) (Elt tv12))
     ((Concat tv13 tv14) (tf0 (tf3 tv13) (tf3 tv14))))))
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
  max
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) y x))
(define-fun-rec
  tf5
  ((x CList)) Nat
  (match x
    (((Single tv20) tv20)
     ((Concat tv21 tv22) (max (tf5 tv21) (tf5 tv22))))))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite2 (lq x y) x y))
(define-fun-rec
  tf11
  ((x List2)) Nat
  (match x
    (((Elt tv40) tv40)
     ((Cons tv41 tv42) (min tv41 (tf11 tv42))))))
(define-fun-rec
  tf7
  ((x CList)) Nat
  (match x
    (((Single tv28) tv28)
     ((Concat tv29 tv30) (min (tf7 tv29) (tf7 tv30))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf9
  ((x CList)) Bool2
  (match x
    (((Single tv34) True)
     ((Concat tv35 tv36)
      (and2 (lq (tf5 tv35) (tf7 tv36)) (and2 (tf9 tv35) (tf9 tv36)))))))
(define-fun
  main
  ((x CList)) Nat (ite2 (tf9 x) (tf11 (tf3 (tf12 x))) Zero))
(define-fun
  mainNew
  ((x CList)) Nat (ite2 (tf9 x) (tf15 x) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
