  (declare-datatypes () ((MyBool (MyTrue) (MyFalse))))
  (declare-datatypes () ((Unit (Null))))
  (declare-datatypes () ((Nat (Zero) (Succ (proj_Succ_0 Nat)))))
  (declare-datatypes () ((Tree (Nil (proj_Nil_0 Unit)) (Node (proj_Node_0 Nat) (proj_Node_1 Tree) (proj_Node_2 Tree)))))
  (declare-fun lq (Nat Nat) MyBool)
  (declare-fun ite1 (MyBool Nat Nat) Nat)
  (declare-fun max (Nat Nat) Nat)
  (declare-fun plus (Nat Nat) Nat)
  (declare-fun tf1 (Nat Tree) Nat)
  (declare-fun tf0 (Nat Tree) Nat)
  (declare-fun spec (Tree) Nat)
  (declare-fun tf3 (Tree) Tree)
  (declare-fun tf2 (Tree) Tree)
  (declare-fun repr (Tree) Tree)
  (declare-fun main (Tree) Nat)
  (declare-fun tf5 (Tree) Nat)
  (declare-fun tf4 (Tree) Nat)
  (declare-fun reprNew (Tree) Nat)
  (declare-fun mainNew (Tree) Nat)
  (assert (= (lq Zero Zero) MyFalse))
  (assert (forall ((x Nat)) (= (lq Zero (Succ x)) MyTrue)))
  (assert (forall ((x Nat)) (= (lq (Succ x) Zero) MyFalse)))
  (assert (forall ((y Nat) (x Nat)) (= (lq (Succ x) (Succ y)) (lq x y))))
  (assert (forall ((y Nat) (x Nat)) (= (ite1 MyTrue x y) x)))
  (assert (forall ((y Nat) (x Nat)) (= (ite1 MyFalse x y) y)))
  (assert (forall ((tv1 Nat) (tv0 Nat)) (= (max tv0 tv1) (ite1 (lq tv0 tv1) tv1 tv0))))
  (assert (forall ((x Nat)) (= (plus Zero x) x)))
  (assert (forall ((y Nat) (x Nat)) (= (plus (Succ x) y) (Succ (plus x y)))))
  (assert (forall ((tv7 Unit) (tv6 Nat)) (= (tf1 tv6 (Nil tv7)) tv6)))
  (assert (forall ((tv9 Tree) (tv8 Nat) (tv10 Tree) (tv6 Nat)) (= (tf1 tv6 (Node tv8 tv9 tv10)) (max (tf0 (plus tv6 tv8) tv9) (tf0 (plus tv6 tv8) tv10)))))
  (assert (forall ((tv4 Tree) (tv3 Nat)) (= (tf0 tv3 tv4) (tf1 tv3 tv4))))
  (assert (forall ((tv2 Tree)) (= (spec tv2) (tf0 Zero tv2))))
  (assert (forall ((tv14 Unit)) (= (tf3 (Nil tv14)) (Nil Null))))
  (assert (forall ((tv16 Tree) (tv17 Tree) (tv15 Nat)) (= (tf3 (Node tv15 tv16 tv17)) (Node tv15 (tf2 tv16) (tf2 tv17)))))
  (assert (forall ((tv12 Tree)) (= (tf2 tv12) (tf3 tv12))))
  (assert (forall ((tv11 Tree)) (= (repr tv11) (tf2 tv11))))
  (assert (forall ((tv18 Tree)) (= (main tv18) (spec (repr tv18)))))
  (assert (forall ((tv22 Unit)) (= (tf5 (Nil tv22)) Zero)))
  (assert (forall ((tv25 Tree) (tv24 Tree) (tv23 Nat)) (= (tf5 (Node tv23 tv24 tv25)) (plus tv23 (max (tf4 tv25) (tf4 tv24))))))
  (assert (forall ((tv20 Tree)) (= (tf4 tv20) (tf5 tv20))))
  (assert (forall ((tv19 Tree)) (= (reprNew tv19) (tf4 tv19))))
  (assert (forall ((tv26 Tree)) (= (mainNew tv26) (reprNew tv26))))
  (assert (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
  (check-sat)
