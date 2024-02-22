(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple0 0))
  (((MakeTuple0 (proj1-MakeTuple0 Nat) (proj2-MakeTuple0 Nat)))))
(declare-datatypes ((List2 0))
  (((Two (proj1-Two Nat) (proj2-Two Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((CList 0))
  (((Ctwo (proj1-Ctwo Nat) (proj2-Ctwo Nat))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf13
  ((x CList)) Nat
  (match x
    (((Ctwo tv54 tv55) tv54)
     ((Concat tv56 tv57) (tf13 tv57)))))
(define-funs-rec
  ((tf10
    ((x CList)) CList)
   (tf11
    ((x CList) (y CList)) CList))
  ((tf11 x x)
   (match y
     (((Ctwo tv46 tv47) x)
      ((Concat tv48 tv49) (Concat tv48 (tf10 tv49)))))))
(define-funs-rec
  ((tf0
    ((x List2) (y List2)) List2)
   (tf1
    ((x List2) (y List2)) List2))
  ((tf1 y x)
   (match y
     (((Two tv6 tv7) (Cons tv6 (Cons tv7 x)))
      ((Cons tv8 tv9) (Cons tv8 (tf0 tv9 x)))))))
(define-fun-rec
  tf3
  ((x CList)) List2
  (match x
    (((Ctwo tv13 tv14) (Two tv13 tv14))
     ((Concat tv15 tv16) (tf0 (tf3 tv15) (tf3 tv16))))))
(define-fun
  snd0
  ((x Tuple0)) Nat (match x (((MakeTuple0 x0 x1) x1))))
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
  ite3
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite3 (lq x y) y x))
(define-fun
  min
  ((x Nat) (y Nat)) Nat (ite3 (lq x y) x y))
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
  fst0
  ((x Tuple0)) Nat (match x (((MakeTuple0 x0 x1) x0))))
(define-fun-rec
  tf5
  ((x List2)) Tuple0
  (match x
    (((Two tv24 tv25) (MakeTuple0 (min tv24 tv25) (max tv24 tv25)))
     ((Cons tv26 tv27)
      (MakeTuple0 (min (fst0 (tf5 tv27)) tv26)
        (min (snd0 (tf5 tv27)) (max (fst0 (tf5 tv27)) tv26)))))))
(define-fun
  spec
  ((x List2)) Nat (snd0 (tf5 x)))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf7
  ((x Nat) (y List2)) Bool2
  (match y
    (((Two tv33 tv34) (and2 (gq x tv33) (gq tv33 tv34)))
     ((Cons tv35 tv36) (and2 (gq x tv35) (tf7 tv35 tv36))))))
(define-fun
  tf9
  ((x List2)) Bool2
  (match x
    (((Two tv38 tv39) (gq tv38 tv39))
     ((Cons tv40 tv41) (tf7 tv40 tv41)))))
(define-fun
  main
  ((x CList)) Nat (ite3 (tf9 (tf3 x)) (spec (tf3 (tf10 x))) Zero))
(define-fun
  mainNew
  ((x CList)) Nat (ite3 (tf9 (tf3 x)) (tf13 x) Zero))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
