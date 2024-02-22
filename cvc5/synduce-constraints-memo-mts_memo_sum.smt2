(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((MList 0))
  (((Ielt (proj1-Ielt Nat))
    (Icons (proj1-Icons Nat) (proj2-Icons Nat) (proj3-Icons MList)))))
(declare-datatypes ((List2 0))
  (((Elt (proj1-Elt Nat))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-funs-rec
  ((tf8
    ((x MList)) MList)
   (tf9
    ((x MList) (y MList)) MList))
  ((tf9 x x)
   (match y
     (((Ielt tv34) x)
      ((Icons tv35 tv36 tv37) (Icons tv35 tv36 (tf8 tv37)))))))
(define-fun-rec
  tf1
  ((x MList)) List2
  (match x
    (((Ielt tv3) (Elt tv3))
     ((Icons tv4 tv5 tv6) (Cons tv4 (tf1 tv6))))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf3
  ((x List2)) Nat
  (match x
    (((Elt tv10) tv10)
     ((Cons tv11 tv12) (plus tv11 (tf3 tv12))))))
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
(define-funs-rec
  ((tf7
    ((x List2) (y List2)) Nat)
   (tf6
    ((x List2)) Nat))
  ((match y
     (((Elt tv27) tv27)
      ((Cons tv28 tv29) (max (tf6 tv29) (tf3 x)))))
   (tf7 x x)))
(define-fun-rec
  tf11
  ((x MList)) Nat
  (match x
    (((Ielt tv42) tv42)
     ((Icons tv43 tv44 tv45)
      (ite2 (lq (tf11 tv45) tv44) tv44 (tf11 tv45))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-funs-rec
  ((tf5
    ((x MList) (y MList)) Bool2)
   (tf4
    ((x MList)) Bool2))
  ((match y
     (((Ielt tv17) True)
      ((Icons tv18 tv19 tv20)
       (and2 (nateq tv19 (tf3 (tf1 x))) (tf4 tv20)))))
   (tf5 x x)))
(define-fun
  main
  ((x MList)) Nat (ite2 (tf4 x) (tf6 (tf1 (tf8 x))) Zero))
(define-fun
  mainNew
  ((x MList)) Nat (ite2 (tf4 x) (tf11 x) Zero))
(assert
  (not (forall ((inp0 MList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
