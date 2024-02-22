(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((Tree 0))
  (((Empty (proj1-Empty Unit))
    (Node (proj1-Node Nat) (proj2-Node Tree) (proj3-Node Tree)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Nat) (proj2-MakeTuple3 Nat)))))
(declare-datatypes ((List2 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Nat) (proj2-Cons List2)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(define-fun-rec
  tf5
  ((x Tree)) Tree
  (match x
    (((Empty tv20) (Empty Null))
     ((Node tv21 tv22 tv23) (Node tv21 (tf5 tv22) (tf5 tv23))))))
(define-fun-rec
  tf1
  ((x List2) (y Tree)) List2
  (match y
    (((Empty tv7) x)
     ((Node tv8 tv9 tv10) (Cons tv8 (tf1 (tf1 x tv9) tv10))))))
(define-fun-rec
  tf3
  ((x Tree)) List2
  (match x
    (((Empty tv13) (Nil Null))
     ((Node tv14 tv15 tv16) (Cons tv14 (tf1 (tf3 tv15) tv16))))))
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
(define-fun
  fst3
  ((x Tuple3)) Nat (match x (((MakeTuple3 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x List2)) Tuple3
  (match x
    (((Nil tv27) (MakeTuple3 Zero Zero))
     ((Cons tv28 tv29)
      (MakeTuple3 (plus tv28 (fst3 (tf7 tv29)))
        (max (snd3 (tf7 tv29)) (plus tv28 (fst3 (tf7 tv29)))))))))
(define-fun
  main
  ((x Tree)) Tuple3 (tf7 (tf3 (tf5 x))))
(define-fun-rec
  tf9
  ((x Tree)) Tuple3
  (match x
    (((Empty tv34) (MakeTuple3 Zero Zero))
     ((Node tv35 tv36 tv37)
      (MakeTuple3 (plus (plus (fst3 (tf9 tv37)) (fst3 (tf9 tv36))) tv35)
        (ite2
          (lq
            (max (plus (snd3 (tf9 tv37)) (fst3 (tf9 tv36))) (snd3 (tf9 tv36)))
            (plus (fst3 (tf9 tv37))
              (max (plus (fst3 (tf9 tv36)) tv35) (fst3 (tf9 tv36)))))
          (plus (fst3 (tf9 tv37))
            (max (plus (fst3 (tf9 tv36)) tv35) (fst3 (tf9 tv36))))
          (max (plus (snd3 (tf9 tv37)) (fst3 (tf9 tv36)))
            (snd3 (tf9 tv36)))))))))
(define-fun
  mainNew
  ((x Tree)) Tuple3 (MakeTuple3 (fst3 (tf9 x)) (snd3 (tf9 x))))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
