  (declare-datatypes () ((MyBool (MyTrue) (MyFalse))))
  (declare-datatypes () ((Unit (Null))))
  (declare-datatypes () ((Nat (Zero) (Succ (proj_Succ_0 Nat)))))
  (declare-datatypes () ((Tree (Nil (proj_Nil_0 Unit)) (Node (proj_Node_0 Nat) (proj_Node_1 Tree) (proj_Node_2 Tree)))))
  (declare-fun lq (Nat Nat) MyBool)
  (declare-fun ite1 (MyBool Nat Nat) Nat)
  (declare-fun max (Nat Nat) Nat)
  (declare-fun plus (Nat Nat) Nat)
  (declare-fun tf1 (Tree) Nat)
  (declare-fun tf0 (Tree) Nat)
  (declare-fun height (Tree) Nat)
  (declare-fun and (MyBool MyBool) MyBool)
  (declare-fun nateq (Nat Nat) MyBool)
  (declare-fun tf3 (Tree) MyBool)
  (declare-fun tf2 (Tree) MyBool)
  (declare-fun balanced (Tree) MyBool)
  (declare-fun tf5 (Tree) Nat)
  (declare-fun tf4 (Tree) Nat)
  (declare-fun spec (Tree) Nat)
  (declare-fun tf7 (Tree) Tree)
  (declare-fun tf6 (Tree) Tree)
  (declare-fun target (Tree) Tree)
  (declare-fun main (Tree) Nat)
  (declare-fun times (Nat Nat) Nat)
  (declare-fun tf9 (Tree) Nat)
  (declare-fun tf8 (Tree) Nat)
  (declare-fun targetNew (Tree) Nat)
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
  (assert (forall ((tv5 Unit)) (= (tf1 (Nil tv5)) Zero)))
  (assert (forall ((tv8 Tree) (tv7 Tree) (tv6 Nat)) (= (tf1 (Node tv6 tv7 tv8)) (plus (Succ Zero) (max (tf0 tv7) (tf0 tv8))))))
  (assert (forall ((tv3 Tree)) (= (tf0 tv3) (tf1 tv3))))
  (assert (forall ((tv2 Tree)) (= (height tv2) (tf0 tv2))))
  (assert (forall ((x MyBool)) (= (and MyFalse x) MyFalse)))
  (assert (forall ((true MyBool)) (= (and true MyFalse) MyFalse)))
  (assert (= (and MyTrue MyTrue) MyTrue))
  (assert (= (nateq Zero Zero) MyTrue))
  (assert (forall ((x Nat)) (= (nateq Zero (Succ x)) MyFalse)))
  (assert (forall ((x Nat)) (= (nateq (Succ x) Zero) MyFalse)))
  (assert (forall ((y Nat) (x Nat)) (= (nateq (Succ x) (Succ y)) (nateq x y))))
  (assert (forall ((tv12 Unit)) (= (tf3 (Nil tv12)) MyTrue)))
  (assert (forall ((tv15 Tree) (tv14 Tree) (tv13 Nat)) (= (tf3 (Node tv13 tv14 tv15)) (and (and (nateq (height tv14) (height tv15)) (tf2 tv14)) (tf2 tv15)))))
  (assert (forall ((tv10 Tree)) (= (tf2 tv10) (tf3 tv10))))
  (assert (forall ((tv9 Tree)) (= (balanced tv9) (tf2 tv9))))
  (assert (forall ((tv19 Unit)) (= (tf5 (Nil tv19)) Zero)))
  (assert (forall ((tv21 Tree) (tv22 Tree) (tv20 Nat)) (= (tf5 (Node tv20 tv21 tv22)) (plus (Succ Zero) (plus (tf4 tv21) (tf4 tv22))))))
  (assert (forall ((tv17 Tree)) (= (tf4 tv17) (tf5 tv17))))
  (assert (forall ((tv16 Tree)) (= (spec tv16) (tf4 tv16))))
  (assert (forall ((tv26 Unit)) (= (tf7 (Nil tv26)) (Nil Null))))
  (assert (forall ((tv29 Tree) (tv28 Tree) (tv27 Nat)) (= (tf7 (Node tv27 tv28 tv29)) (Node tv27 (tf6 tv28) tv29))))
  (assert (forall ((tv24 Tree)) (= (tf6 tv24) (tf7 tv24))))
  (assert (forall ((tv23 Tree)) (= (target tv23) (tf6 tv23))))
  (assert (forall ((tv30 Tree)) (= (main tv30) (ite1 (balanced tv30) (spec (target tv30)) Zero))))
  (assert (forall ((x Nat)) (= (times Zero x) Zero)))
  (assert (forall ((y Nat) (x Nat)) (= (times (Succ x) y) (plus (times x y) y))))
  (assert (forall ((tv34 Unit)) (= (tf9 (Nil tv34)) Zero)))
  (assert (forall ((tv37 Tree) (tv36 Tree) (tv35 Nat)) (= (tf9 (Node tv35 tv36 tv37)) (plus (times (Succ (Succ Zero)) (tf8 tv36)) (max (tf8 tv36) (Succ Zero))))))
  (assert (forall ((tv32 Tree)) (= (tf8 tv32) (tf9 tv32))))
  (assert (forall ((tv31 Tree)) (= (targetNew tv31) (tf8 tv31))))
  (assert (forall ((tv38 Tree)) (= (mainNew tv38) (ite1 (balanced tv38) (targetNew tv38) Zero))))
  (assert (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
  (check-sat)
