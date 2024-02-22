(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Formula 0))
  (((Flit (proj1-Flit Bool2))
    (Fand (proj1-Fand Formula) (proj2-Fand Formula))
    (Forr (proj1-Forr Formula) (proj2-Forr Formula))
    (Fnot (proj1-Fnot Formula)))))
(declare-datatypes ((NnfFormula 0))
  (((Nfneglit (proj1-Nfneglit Bool2)) (Nflit (proj1-Nflit Bool2))
    (Nfand (proj1-Nfand NnfFormula) (proj2-Nfand NnfFormula))
    (Nfor (proj1-Nfor NnfFormula) (proj2-Nfor NnfFormula)))))
(define-fun-rec
  tf3
  ((x NnfFormula)) Formula
  (match x
    (((Nfneglit tv13) (Fnot (Flit tv13)))
     ((Nflit tv12) (Flit tv12))
     ((Nfand tv14 tv15) (Fand (tf3 tv14) (tf3 tv15)))
     ((Nfor tv16 tv17) (Forr (tf3 tv16) (tf3 tv17))))))
(define-fun
  or2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True True)
     (False y))))
(define-fun
  not2
  ((x Bool2)) Bool2
  (match x
    ((True False)
     (False True))))
(define-fun
  ite2
  ((x Bool2)) Bool2
  (match x
    ((True False)
     (False True))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf1
  ((x Formula)) Bool2
  (match x
    (((Flit tv3) tv3)
     ((Fand tv4 tv5) (and2 (tf1 tv4) (tf1 tv5)))
     ((Forr tv6 tv7) (or2 (tf1 tv6) (tf1 tv7)))
     ((Fnot tv8)
      (match (tf1 tv8)
        ((True False)
         (False True)))))))
(define-fun
  main
  ((x NnfFormula)) Bool2 (tf1 (tf3 x)))
(define-fun-rec
  tf5
  ((x NnfFormula)) Bool2
  (match x
    (((Nfneglit tv23)
      (match tv23
        ((True False)
         (False True))))
     ((Nflit tv22) tv22)
     ((Nfand tv24 tv25) (and2 (tf5 tv25) (tf5 tv24)))
     ((Nfor tv26 tv27) (or2 (tf5 tv26) (tf5 tv27))))))
(assert
  (not (forall ((inp0 NnfFormula)) (= (main inp0) (tf5 inp0)))))
(check-sat)
