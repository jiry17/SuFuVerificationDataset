(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((UList 0))
  (((Uelt (proj1-Uelt Nat))
    (Usplit (proj1-Usplit UList)
      (proj2-Usplit Nat) (proj3-Usplit Nat) (proj4-Usplit UList)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf1
  ((x List2) (y UList)) List2
  (match y
    (((Uelt tv5) (Cons tv5 x))
     ((Usplit tv6 tv7 tv8 tv9)
      (tf1 (Cons tv7 (Cons tv8 (tf1 x tv9))) tv6)))))
(define-fun-rec
  tf3
  ((x UList)) List2
  (match x
    (((Uelt tv12) (Elt tv12))
     ((Usplit tv13 tv14 tv15 tv16)
      (tf1 (Cons tv14 (Cons tv15 (tf3 tv16))) tv13)))))
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
  tf11
  ((x List2)) Nat
  (match x
    (((Elt tv41) tv41)
     ((Cons tv42 tv43) (max tv42 (tf11 tv43))))))
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
  tf13
  ((x UList)) UList
  (match x
    (((Uelt tv47) (Uelt tv47))
     ((Usplit tv48 tv49 tv50 tv51)
      (ite4 (gq tv49 tv50)
        (Usplit (tf13 tv48) tv49 tv50 tv51)
        (Usplit tv48 tv49 tv50 (tf13 tv51)))))))
(define-fun-rec
  tf15
  ((x UList)) Nat
  (match x
    (((Uelt tv56) tv56)
     ((Usplit tv57 tv58 tv59 tv60)
      (ite3 (gq tv58 tv59)
        (max tv58 (tf15 tv57)) (max tv59 (tf15 tv60)))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf5
  ((x Nat) (y List2)) Bool2
  (match y
    (((Elt tv22) (gq x tv22))
     ((Cons tv23 tv24) (and2 (gq x tv23) (tf5 tv23 tv24))))))
(define-fun-rec
  tf7
  ((x Nat) (y List2)) Bool2
  (match y
    (((Elt tv29) (lq x tv29))
     ((Cons tv30 tv31)
      (ite2 (lq x tv30) (tf7 tv30 tv31) (tf5 tv30 tv31))))))
(define-fun
  tf9
  ((x List2)) Bool2
  (match x
    (((Elt tv33) True)
     ((Cons tv34 tv35) (tf7 tv34 tv35)))))
(define-fun
  main
  ((x UList)) Nat (ite3 (tf9 (tf3 x)) (tf11 (tf3 (tf13 x))) Zero))
(define-fun
  mainNew
  ((x UList)) Nat (ite3 (tf9 (tf3 x)) (tf15 x) Zero))
(assert
  (not (forall ((inp0 UList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
