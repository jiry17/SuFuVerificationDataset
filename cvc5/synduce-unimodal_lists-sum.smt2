(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((UList 0))
  (((Unil (proj1-Unil Unit)) (Uelt (proj1-Uelt Nat))
    (Usplit (proj1-Usplit UList)
      (proj2-Usplit Nat) (proj3-Usplit Nat) (proj4-Usplit UList)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf11
  ((x UList)) UList
  (match x
    (((Unil tv39) (Unil Null))
     ((Uelt tv40) (Uelt tv40))
     ((Usplit tv41 tv42 tv43 tv44)
      (Usplit (tf11 tv41) tv42 tv43 (tf11 tv44))))))
(define-fun-rec
  tf1
  ((x List2) (y UList)) List2
  (match y
    (((Unil tv5) x)
     ((Uelt tv6) (Cons tv6 x))
     ((Usplit tv7 tv8 tv9 tv10)
      (tf1 (Cons tv8 (Cons tv9 (tf1 x tv10))) tv7)))))
(define-fun
  repr
  ((x UList)) List2 (tf1 (Nil Null) x))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf13
  ((x UList)) Nat
  (match x
    (((Unil tv49) Zero)
     ((Uelt tv50) tv50)
     ((Usplit tv51 tv52 tv53 tv54)
      (plus (tf13 tv54) (plus (tf13 tv51) (plus tv52 tv53)))))))
(define-fun-rec
  tf9
  ((x List2)) Nat
  (match x
    (((Nil tv33) Zero)
     ((Cons tv34 tv35) (plus tv34 (tf9 tv35))))))
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
  ite3
  ((x Bool2) (y Nat)) Nat
  (match x
    ((True y)
     (False Zero))))
(define-fun
  ite2
  ((x Bool2) (y Bool2) (z Bool2)) Bool2
  (match x
    ((True y)
     (False z))))
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
  tf3
  ((x Nat) (y List2)) Bool2
  (match y
    (((Nil tv16) True)
     ((Cons tv17 tv18) (and2 (geq x tv17) (tf3 tv17 tv18))))))
(define-fun-rec
  tf5
  ((x Nat) (y List2)) Bool2
  (match y
    (((Nil tv23) True)
     ((Cons tv24 tv25)
      (ite2 (leq x tv24) (tf5 tv24 tv25) (tf3 tv24 tv25))))))
(define-fun
  tf7
  ((x List2)) Bool2
  (match x
    (((Nil tv27) True)
     ((Cons tv28 tv29) (tf5 tv28 tv29)))))
(define-fun
  main
  ((x UList)) Nat (ite3 (tf7 (repr x)) (tf9 (repr (tf11 x)))))
(define-fun
  mainNew
  ((x UList)) Nat (ite3 (tf7 (repr x)) (tf13 x)))
(assert
  (not (forall ((inp0 UList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
