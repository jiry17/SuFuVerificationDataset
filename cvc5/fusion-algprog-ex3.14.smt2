(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((PTree 0))
  (((Ptip (proj1-Ptip Nat) (proj2-Ptip Nat))
    (Pbin (proj1-Pbin PTree) (proj2-Pbin PTree)))))
(declare-datatypes ((Tree 0))
  (((Tip (proj1-Tip Nat)) (Bin (proj1-Bin Tree) (proj2-Bin Tree)))))
(declare-datatypes ((Tuple1 0))
  (((MakeTuple1 (proj1-MakeTuple1 Nat) (proj2-MakeTuple1 Nat)))))
(define-fun
  snd1
  ((x Tuple1)) Nat (match x (((MakeTuple1 x0 x1) x1))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun-rec
  tf3
  ((x PTree)) PTree
  (match x
    (((Ptip tv8 tv9) (Ptip (plus tv8 (Succ Zero)) tv9))
     ((Pbin tv10 tv11) (Pbin (tf3 tv10) (tf3 tv11))))))
(define-fun-rec
  tf1
  ((x Tree)) PTree
  (match x
    (((Tip tv3) (Ptip Zero tv3))
     ((Bin tv4 tv5) (Pbin (tf3 (tf1 tv4)) (tf3 (tf1 tv5)))))))
(define-fun-rec
  times
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero Zero)
     ((Succ x1) (plus (times x1 y) y)))))
(define-fun-rec
  tf5
  ((x PTree)) Nat
  (match x
    (((Ptip tv15 tv16) (times tv15 tv16))
     ((Pbin tv17 tv18) (plus (tf5 tv17) (tf5 tv18))))))
(define-fun
  main
  ((x Tree)) Nat (tf5 (tf1 x)))
(define-fun
  fst1
  ((x Tuple1)) Nat (match x (((MakeTuple1 x0 x1) x0))))
(define-fun-rec
  tf7
  ((x Tree)) Tuple1
  (match x
    (((Tip tv23) (MakeTuple1 Zero tv23))
     ((Bin tv24 tv25)
      (MakeTuple1
        (plus
          (plus (plus (fst1 (tf7 tv24)) (snd1 (tf7 tv24))) (fst1 (tf7 tv25)))
          (snd1 (tf7 tv25)))
        (plus (snd1 (tf7 tv24)) (snd1 (tf7 tv25))))))))
(define-fun
  mainNew
  ((x Tree)) Nat (fst1 (tf7 x)))
(assert
  (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
(check-sat)
