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
  ite4
  ((x Bool2) (y UList) (z UList)) UList
  (match x
    ((True y)
     (False z))))
(define-fun
  ite3
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite3 (lq x y) y x))
(define-fun-rec
  tf9
  ((x List2)) Nat
  (match x
    (((Nil tv35) Zero)
     ((Cons tv36 tv37) (max tv36 (tf9 tv37))))))
(define-fun
  ite2
  ((x Bool2) (y Bool2) (z Bool2)) Bool2
  (match x
    ((True y)
     (False z))))
(define-fun-rec
  gq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero False)
     ((Succ x1)
      (match y
        ((Zero True)
         ((Succ z) (gq x1 z))))))))
(define-fun-rec
  tf11
  ((x UList)) UList
  (match x
    (((Unil tv41) (Unil Null))
     ((Uelt tv42) (Uelt tv42))
     ((Usplit tv43 tv44 tv45 tv46)
      (ite4 (gq tv44 tv45)
        (Usplit (tf11 tv43) tv44 tv45 tv46)
        (Usplit tv43 tv44 tv45 (tf11 tv46)))))))
(define-fun-rec
  tf13
  ((x UList)) Nat
  (match x
    (((Unil tv51) Zero)
     ((Uelt tv52) tv52)
     ((Usplit tv53 tv54 tv55 tv56)
      (ite3 (gq tv54 tv55)
        (max tv54 (tf13 tv53))
        (ite3 (lq (tf13 tv56) tv55) tv55 (tf13 tv56)))))))
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
    (((Nil tv16) (gq x Zero))
     ((Cons tv17 tv18)
      (and2 (gq x Zero) (and2 (gq x tv17) (tf3 tv17 tv18)))))))
(define-fun-rec
  tf5
  ((x Nat) (y List2)) Bool2
  (match y
    (((Nil tv23) (gq x Zero))
     ((Cons tv24 tv25)
      (and2 (gq x Zero)
        (ite2 (lq x tv24) (tf5 tv24 tv25) (tf3 tv24 tv25)))))))
(define-fun
  tf7
  ((x List2)) Bool2
  (match x
    (((Nil tv27) True)
     ((Cons tv28 tv29) (tf5 tv28 tv29)))))
(define-fun
  main
  ((x UList)) Nat (ite3 (tf7 (repr x)) (tf9 (repr (tf11 x))) Zero))
(define-fun
  mainNew
  ((x UList)) Nat (ite3 (tf7 (repr x)) (tf13 x) Zero))
(assert
  (not (forall ((inp0 UList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
