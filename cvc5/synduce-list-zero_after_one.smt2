(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((CList 0))
  (((Emp (proj1-Emp Unit)) (Single (proj1-Single Bool2))
    (Concat (proj1-Concat CList) (proj2-Concat CList)))))
(declare-datatypes ((Tuple2 0))
  (((MakeTuple2 (proj1-MakeTuple2 Bool2)
      (proj2-MakeTuple2 Bool2) (proj3-MakeTuple2 Bool2)))))
(declare-datatypes ((Tuple3 0))
  (((MakeTuple3 (proj1-MakeTuple3 Bool2)
      (proj2-MakeTuple3 Bool2) (proj3-MakeTuple3 Bool2)
      (proj4-MakeTuple3 Bool2)))))
(declare-datatypes ((BList 0))
  (((Nil (proj1-Nil Unit))
    (Cons (proj1-Cons Bool2) (proj2-Cons BList)))))
(define-fun
  third3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1 x2 x3) x2))))
(define-fun
  third2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x2))))
(define-funs-rec
  ((tf0
    ((x BList) (y BList)) BList)
   (tf1
    ((x BList) (y BList)) BList))
  ((tf1 y x)
   (match y
     (((Nil tv8) x)
      ((Cons tv9 tv10) (Cons tv9 (tf0 tv10 x)))))))
(define-fun-rec
  tf3
  ((x CList)) BList
  (match x
    (((Emp tv14) (Nil Null))
     ((Single tv15) (Cons tv15 (Nil Null)))
     ((Concat tv16 tv17) (tf0 (tf3 tv16) (tf3 tv17))))))
(define-fun
  snd3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1 x2 x3) x1))))
(define-fun
  snd2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x1))))
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
  fst3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1 x2 x3) x0))))
(define-fun
  fst2
  ((x Tuple2)) Bool2 (match x (((MakeTuple2 x0 x1 x2) x0))))
(define-fun
  fourth3
  ((x Tuple3)) Bool2 (match x (((MakeTuple3 x0 x1 x2 x3) x3))))
(define-fun
  and2
  ((x Bool2) (y Bool2)) Bool2
  (match x
    ((True y)
     (False False))))
(define-fun-rec
  tf5
  ((x BList)) Tuple2
  (match x
    (((Nil tv21) (MakeTuple2 False False False))
     ((Cons tv22 tv23)
      (match tv22
        ((True
          (MakeTuple2 (or2 (fst2 (tf5 tv23)) True)
            (or2 (snd2 (tf5 tv23)) (and2 (fst2 (tf5 tv23)) False))
            (third2 (tf5 tv23))))
         (False
          (MakeTuple2 (fst2 (tf5 tv23))
            (or2 (snd2 (tf5 tv23)) (fst2 (tf5 tv23)))
            (or2 (third2 (tf5 tv23)) True)))))))))
(define-fun
  spec
  ((x BList)) Bool2 (snd2 (tf5 x)))
(define-fun
  main
  ((x CList)) Bool2 (spec (tf3 x)))
(define-fun-rec
  tf7
  ((x CList)) Tuple3
  (match x
    (((Emp tv28) (MakeTuple3 False True True False))
     ((Single tv29) (MakeTuple3 False tv29 False False))
     ((Concat tv30 tv31)
      (match (snd3 (tf7 tv30))
        ((True
          (match (third3 (tf7 tv31))
            ((True
              (match (third3 (tf7 tv31))
                ((True
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))))))))
                 (False
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))))))))
             (False
              (match (third3 (tf7 tv31))
                ((True
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))))))))
                 (False
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))))))))))))))
         (False
          (match (third3 (tf7 tv31))
            ((True
              (match (third3 (tf7 tv31))
                ((True
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              False)
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))))))))
                 (False
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                            (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))))))))
             (False
              (match (third3 (tf7 tv31))
                ((True
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2
                                              (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                                False)
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))))))))
                 (False
                  (match (third3 (tf7 tv30))
                    ((True
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (and2 (snd3 (tf7 tv30)) False))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30))))))))))))))))))
                     (False
                      (match (snd3 (tf7 tv31))
                        ((True
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))
                         (False
                          (match (third3 (tf7 tv30))
                            ((True
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))))))))
                             (False
                              (match (snd3 (tf7 tv30))
                                ((True
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30)))))))))
                                 (False
                                  (match (third3 (tf7 tv31))
                                    ((True
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (or2 (fourth3 (tf7 tv31)) (fourth3 (tf7 tv30))))))
                                     (False
                                      (MakeTuple3
                                        (or2
                                          (or2 (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))
                                            (and2 (or2 (fst3 (tf7 tv31)) (fourth3 (tf7 tv30)))
                                              (or2 (fst3 (tf7 tv31)) (snd3 (tf7 tv31)))))
                                          (or2 (fst3 (tf7 tv31)) (fst3 (tf7 tv30))))
                                        (or2 (and2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                          (snd3 (tf7 tv30)))
                                        (and2 (third3 (tf7 tv31)) (third3 (tf7 tv30)))
                                        (or2
                                          (or2 (or2 (snd3 (tf7 tv31)) (snd3 (tf7 tv30)))
                                            (or2 (snd3 (tf7 tv31)) (fourth3 (tf7 tv31))))
                                          (or2 (fourth3 (tf7 tv31))
                                            (fourth3 (tf7 tv30)))))))))))))))))))))))))))))))))
(define-fun
  mainNew
  ((x CList)) Bool2 (fst3 (tf7 x)))
(assert
  (not (forall ((inp0 CList)) (= (main inp0) (mainNew inp0)))))
(check-sat)
