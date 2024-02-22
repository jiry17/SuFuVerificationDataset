(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Cnil (proj1-Cnil Unit)) (Single (proj1-Single Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf9
  ((x CList)) CList
  (match x
    (((Cnil tv34) (Cnil Null))
     ((Single tv35) (Single tv35))
     ((Concat tv36 tv37) (Concat (tf9 tv36) (tf9 tv37))))))
(define-funs-rec
  ((tf2
    ((x List2) (y List2)) List2)
   (tf3
    ((x List2) (y List2)) List2))
  ((tf3 y x)
   (match y
     (((Nil tv15) x)
      ((Cons tv13 tv14) (Cons tv13 (tf2 tv14 x)))))))
(define-fun-rec
  tf5
  ((x CList)) List2
  (match x
    (((Cnil tv19) (Nil Null))
     ((Single tv20) (Cons tv20 (Nil Null)))
     ((Concat tv21 tv22) (tf2 (tf5 tv21) (tf5 tv22))))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf11
  ((x CList)) Nat
  (match x
    (((Cnil tv42) Zero)
     ((Single tv43) tv43)
     ((Concat tv44 tv45) (plus (tf11 tv45) (tf11 tv44))))))
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
  ((x Nat)) Nat (ite2 (lq x Zero) Zero x))
(define-fun-rec
  tf7
  ((x List2)) Nat
  (match x
    (((Nil tv28) Zero)
     ((Cons tv29 tv30) (max (plus (tf7 tv30) tv29))))))
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
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf1
  ((x CList)) Bool2
  (match x
    (((Cnil tv3) True)
     ((Single tv4) (gq tv4 Zero))
     ((Concat tv5 tv6) (and2 (tf1 tv5) (tf1 tv6))))))
(define-fun
  main
  ((x CList)) Nat (ite2 (tf1 x) (tf7 (tf5 (tf9 x))) Zero))
(define-fun
  mainNew
  ((x CList)) Nat (ite2 (tf1 x) (tf11 x) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
