(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((IDList 0))
  (((Inil (proj1-Inil Unit))
    (Icons (proj1-Icons Nat) (proj2-Icons Nat) (proj3-Icons IDList)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf5
  ((x IDList)) List2
  (match x
    (((Inil tv17) (Nil Null))
     ((Icons tv18 tv19 tv20) (Cons tv18 (tf5 tv20))))))
(define-funs-rec
  ((tf10
    ((x IDList)) IDList)
   (tf11
    ((x IDList) (y IDList)) IDList))
  ((tf11 x x)
   (match y
     (((Inil tv37) x)
      ((Icons tv38 tv39 tv40) (Icons tv38 tv39 (tf10 tv40)))))))
(define-fun
  snd3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x1))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf1
  ((x IDList)) Nat
  (match x
    (((Inil tv3) Zero)
     ((Icons tv4 tv5 tv6) (plus (Succ Zero) (tf1 tv6))))))
(define-fun-rec
  tf7
  ((x List2)) Nat
  (match x
    (((Nil tv24) Zero)
     ((Cons tv25 tv26) (plus (Succ Zero) (tf7 tv26))))))
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
  leq
  ((x Nat) (y Nat)) Bool2
  (match x
    ((Zero True)
     ((Succ x1)
      (match y
        ((Zero False)
         ((Succ z) (leq x1 z))))))))
(define-fun
  ite2
  ((x Bool2) (y Nat) (z Nat)) Nat
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
  tf9
  ((x List2)) Nat
  (match x
    (((Nil tv30) Zero)
     ((Cons tv31 tv32)
      (ite2 (gq tv31 (tf7 tv32)) (plus tv31 (tf9 tv32)) (tf9 tv32))))))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf13
  ((x IDList)) Tuple3
  (match x
    (((Inil tv45) (MakeTuple3 Zero Zero))
     ((Icons tv46 tv47 tv48)
      (MakeTuple3
        (ite2 (leq tv46 (snd3 (tf13 tv48)))
          (fst3 (tf13 tv48)) (plus tv46 (fst3 (tf13 tv48))))
        (plus (snd3 (tf13 tv48)) (Succ Zero)))))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf3
  ((x IDList)) Bool2
  (match x
    (((Inil tv10) True)
     ((Icons tv11 tv12 tv13)
      (and2 (tf3 tv13) (nateq tv12 (tf1 tv13)))))))
(define-fun
  main
  ((x IDList)) Nat (ite2 (tf3 x) (tf9 (tf5 (tf10 x))) Zero))
(define-fun
  mainNew
  ((x IDList)) Nat (ite2 (tf3 x) (fst3 (tf13 x)) Zero))
(assert
  (not (forall ((inp0 IDList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
