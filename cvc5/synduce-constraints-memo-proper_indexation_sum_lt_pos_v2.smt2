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
(define-funs-rec
  ((tf8
    ((x IDList)) IDList)
   (tf9
    ((x IDList) (y IDList)) IDList))
  ((tf9 x x)
   (match y
     (((Inil tv33) x)
      ((Icons tv34 tv35 tv36) (Icons tv34 tv35 (tf8 tv36)))))))
(define-fun-rec
  tf5
  ((x IDList)) List2
  (match x
    (((Inil tv17) (Nil Null))
     ((Icons tv18 tv19 tv20) (Cons tv18 (tf5 tv20))))))
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
  ite3
  ((x Bool2) (y Tuple3)) Tuple3
  (match x
    ((True y)
     (False (MakeTuple3 Zero Zero)))))
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
(define-fun
  max
  ((x Nat)) Nat (ite2 (gq x Zero) x Zero))
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf11
  ((x IDList)) Tuple3
  (match x
    (((Inil tv41) (MakeTuple3 Zero Zero))
     ((Icons tv42 tv43 tv44)
      (MakeTuple3
        (ite2 (leq tv42 (snd3 (tf11 tv44)))
          (fst3 (tf11 tv44)) (plus (fst3 (tf11 tv44)) tv42))
        (plus (Succ Zero) (snd3 (tf11 tv44))))))))
(define-fun-rec
  tf7
  ((x List2)) Tuple3
  (match x
    (((Nil tv26) (MakeTuple3 Zero Zero))
     ((Cons tv27 tv28)
      (MakeTuple3
        (ite2 (gq tv27 (snd3 (tf7 tv28)))
          (max (plus (fst3 (tf7 tv28)) tv27)) (fst3 (tf7 tv28)))
        (plus (snd3 (tf7 tv28)) (Succ Zero)))))))
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
  ((x IDList)) Tuple3 (ite3 (tf3 x) (tf7 (tf5 (tf8 x)))))
(define-fun
  mainNew
  ((x IDList)) Tuple3
  (ite3 (tf3 x) (MakeTuple3 (fst3 (tf11 x)) (snd3 (tf11 x)))))
(assert
  (not (forall ((inp0 IDList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
