(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple0 0))
  (((MakeTuple0 (proj1-MakeTuple0 Nat) (proj2-MakeTuple0 Nat)))))
(declare-datatypes ((MyNat 0))
  (((Myzero (proj1-Myzero Unit)) (Mysucc (proj1-Mysucc MyNat)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf2
    ((x MyNat)) MyNat)
   (tf3
    ((x MyNat) (y MyNat)) MyNat))
  ((tf3 x x)
   (match y
     (((Myzero tv10) x)
      ((Mysucc tv11) (Mysucc (tf2 tv11)))))))
(define-fun
  snd0
  ((x Tuple0)) Nat (match x (((MakeTuple0 x0 x1) x1))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x MyNat)) Nat
  (match x
    (((Myzero tv3) Zero)
     ((Mysucc y)
      (match y
        (((Myzero tv4) (Succ Zero))
         ((Mysucc tv5) (plus (tf1 tv5) (tf1 (Mysucc tv5))))))))))
(define-fun-rec
  nateq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero
      (match y
        ((Zero True)
         ((Succ z) False))))
     ((Succ x2)
      (match y
        ((Zero False)
         ((Succ y2) (nateq x2 y2))))))))
(define-fun
  main
  ((x MyNat)) Nat (tf1 (tf2 x)))
(define-fun
  ite1
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  fst0
  ((x Tuple0)) Nat (match x (((MakeTuple0 x0 x1) x0))))
(define-fun-rec
  tf5
  ((x MyNat)) Tuple0
  (match x
    (((Myzero tv16) (MakeTuple0 Zero Zero))
     ((Mysucc tv17)
      (MakeTuple0
        (ite1 (nateq (fst0 (tf5 tv17)) (snd0 (tf5 tv17)))
          (plus (Succ Zero) (fst0 (tf5 tv17)))
          (plus (fst0 (tf5 tv17)) (snd0 (tf5 tv17))))
        (fst0 (tf5 tv17)))))))
(define-fun
  mainNew
  ((x MyNat)) Nat (fst0 (tf5 x)))
(assert
  (not (forall ((inp0 MyNat)) (= (main inp0) (mainNew inp0)))))
(check-sat)
