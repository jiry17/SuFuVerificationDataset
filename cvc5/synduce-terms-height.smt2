(declare-datatypes ((Unit 0)) (((Null))))
(declare-datatypes ((Op 0))
  (((OpPlus (proj1-OpPlus Unit)) (OpMinus (proj1-OpMinus Unit))
    (OpNot (proj1-OpNot Unit)) (OpAnd (proj1-OpAnd Unit))
    (OpOr (proj1-OpOr Unit)) (OpGt (proj1-OpGt Unit))
    (OpEq (proj1-OpEq Unit)))))
(declare-datatypes ((Nat 0)) (((Zero) (Succ (proj1-Succ Nat)))))
(declare-datatypes ((BoolOp 0))
  (((BNot (proj1-BNot Unit)) (BAnd (proj1-BAnd Unit))
    (BOr (proj1-BOr Unit)) (BEq (proj1-BEq Unit)))))
(declare-datatypes ((Bool2 0)) (((True) (False))))
(declare-datatypes ((Term2 0))
  (((Bin (proj1-Bin Op) (proj2-Bin Term2) (proj3-Bin Term2))
    (Un (proj1-Un Op) (proj2-Un Term2)) (Var (proj1-Var Nat))
    (CInt (proj1-CInt Nat)) (CBool (proj1-CBool Bool2)))))
(declare-datatypes ((ArithOp 0))
  (((APlus (proj1-APlus Unit)) (AMinus (proj1-AMinus Unit))
    (AGt (proj1-AGt Unit)))))
(declare-datatypes ((Term 0))
  (((TArithBin (proj1-TArithBin ArithOp)
      (proj2-TArithBin Term) (proj3-TArithBin Term))
    (TBoolBin (proj1-TBoolBin BoolOp)
      (proj2-TBoolBin Term) (proj3-TBoolBin Term))
    (TArithUn (proj1-TArithUn ArithOp) (proj2-TArithUn Term))
    (TBoolUn (proj1-TBoolUn BoolOp) (proj2-TBoolUn Term))
    (TVar (proj1-TVar Nat)) (TCInt (proj1-TCInt Nat))
    (TCBool (proj1-TCBool Bool2)))))
(define-fun-rec
  tf7
  ((x Term2)) Term2
  (match x
    (((Bin tv54 tv55 tv56) (Bin tv54 (tf7 tv55) (tf7 tv56)))
     ((Un tv57 tv58) (Un tv57 (tf7 tv58)))
     ((Var tv59) (Var tv59))
     ((CInt tv60) (CInt tv60))
     ((CBool tv61) (CBool tv61)))))
(define-fun
  tf1
  ((x Term) (y Op)) Term
  (match y
    (((OpPlus tv15) (TArithUn (APlus Null) x))
     ((OpMinus tv16) (TArithUn (AMinus Null) x))
     ((OpNot tv17) (TBoolUn (BNot Null) x))
     ((OpAnd tv18) (TBoolUn (BAnd Null) x))
     ((OpOr tv19) (TBoolUn (BOr Null) x))
     ((OpGt tv20) (TArithUn (AGt Null) x))
     ((OpEq tv21) (TBoolUn (BEq Null) x)))))
(define-fun
  tf0
  ((x Term) (y Term) (z Op)) Term
  (match z
    (((OpPlus tv5) (TArithBin (APlus Null) y x))
     ((OpMinus tv6) (TArithBin (AMinus Null) y x))
     ((OpNot tv7) (TBoolBin (BNot Null) y x))
     ((OpAnd tv8) (TBoolBin (BAnd Null) y x))
     ((OpOr tv9) (TBoolBin (BOr Null) y x))
     ((OpGt tv10) (TArithBin (AGt Null) y x))
     ((OpEq tv11) (TBoolBin (BEq Null) y x)))))
(define-fun-rec
  plus
  ((x Nat) (y Nat)) Nat
  (match x
    ((Zero y)
     ((Succ x1) (Succ (plus x1 y))))))
(define-fun
  mkbin
  ((x Term) (y Term) (z Op)) Term (tf0 y x z))
(define-fun-rec
  tf3
  ((x Term2)) Term
  (match x
    (((Bin tv25 tv26 tv27) (mkbin (tf3 tv26) (tf3 tv27) tv25))
     ((Un tv28 tv29) (tf1 (tf3 tv29) tv28))
     ((Var tv30) (TVar tv30))
     ((CInt tv31) (TCInt tv31))
     ((CBool tv32) (TCBool tv32)))))
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
  ite6
  ((x Bool2) (y Nat) (z Nat)) Nat
  (match x
    ((True y)
     (False z))))
(define-fun
  max
  ((x Nat) (y Nat)) Nat (ite6 (lq x y) y x))
(define-fun-rec
  tf5
  ((x Term)) Nat
  (match x
    (((TArithBin tv38 tv39 tv40)
      (plus (Succ Zero) (max (tf5 tv39) (tf5 tv40))))
     ((TBoolBin tv41 tv42 tv43)
      (plus (Succ Zero) (max (tf5 tv42) (tf5 tv43))))
     ((TArithUn tv44 tv45) (plus (Succ Zero) (tf5 tv45)))
     ((TBoolUn tv46 tv47) (plus (Succ Zero) (tf5 tv47)))
     ((TVar tv48) (Succ Zero))
     ((TCInt tv49) (Succ Zero))
     ((TCBool tv50) (Succ Zero)))))
(define-fun
  main
  ((x Term2)) Nat (tf5 (tf3 (tf7 x))))
(define-fun-rec
  tf9
  ((x Term2)) Nat
  (match x
    (((Bin tv66 tv67 tv68)
      (plus (Succ Zero) (max (tf9 tv67) (tf9 tv68))))
     ((Un tv69 tv70) (plus (Succ Zero) (tf9 tv70)))
     ((Var tv71) (Succ Zero))
     ((CInt tv72) (Succ Zero))
     ((CBool tv73) (Succ Zero)))))
(assert (not (forall ((inp0 Term2)) (= (main inp0) (tf9 inp0)))))
(check-sat)
