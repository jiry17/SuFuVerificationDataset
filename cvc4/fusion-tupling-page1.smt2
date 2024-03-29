  (declare-datatypes () ((MyBool (MyTrue) (MyFalse))))
  (declare-datatypes () ((Nat (Zero) (Succ (proj_Succ_0 Nat)))))
  (declare-datatypes () ((Tree (Leaf (proj_Leaf_0 Nat)) (Node (proj_Node_0 Tree) (proj_Node_1 Tree)))))
  (declare-datatypes () ((Unit (Null))))
  (declare-datatypes () ((List (Nil (proj_Nil_0 Unit)) (Cons (proj_Cons_0 Nat) (proj_Cons_1 List)))))
  (declare-fun tf1 (List List) List)
  (declare-fun tf0 (List List) List)
  (declare-fun cat (List List) List)
  (declare-fun lq (Nat Nat) MyBool)
  (declare-fun ite2 (MyBool Nat Nat) Nat)
  (declare-fun max (Nat Nat) Nat)
  (declare-fun plus (Nat Nat) Nat)
  (declare-fun tf3 (Tree) Nat)
  (declare-fun tf2 (Tree) Nat)
  (declare-fun depth (Tree) Nat)
  (declare-datatypes () ((Tuple3 (MakeTuple3 (proj_MakeTuple3_0 List) (proj_MakeTuple3_1 Tree)))))
  (declare-fun gq (Nat Nat) MyBool)
  (declare-fun snd3 (Tuple3) Tree)
  (declare-fun fst3 (Tuple3) List)
  (declare-fun nateq (Nat Nat) MyBool)
  (declare-fun ite3 (MyBool Tuple3 Tuple3) Tuple3)
  (declare-fun tf5 (Tree Tree) Tuple3)
  (declare-fun tf4 (Tree) Tuple3)
  (declare-fun deepest (Tree) Tuple3)
  (declare-fun main (Tree) List)
  (declare-datatypes () ((Tuple4 (MakeTuple4 (proj_MakeTuple4_0 List) (proj_MakeTuple4_1 Nat)))))
  (declare-fun snd4 (Tuple4) Nat)
  (declare-fun fst4 (Tuple4) List)
  (declare-fun ite4 (MyBool Tuple4 Tuple4) Tuple4)
  (declare-fun tf7 (Tree) Tuple4)
  (declare-fun tf6 (Tree) Tuple4)
  (declare-fun deepestNew (Tree) Tuple4)
  (declare-fun mainNew (Tree) List)
  (assert (forall ((tv6 Unit) (tv5 List)) (= (tf1 tv5 (Nil tv6)) tv5)))
  (assert (forall ((tv8 List) (tv7 Nat) (tv5 List)) (= (tf1 tv5 (Cons tv7 tv8)) (Cons tv7 (tf0 tv8 tv5)))))
  (assert (forall ((tv3 List) (tv2 List)) (= (tf0 tv2 tv3) (tf1 tv3 tv2))))
  (assert (forall ((tv1 List) (tv0 List)) (= (cat tv0 tv1) (tf0 tv0 tv1))))
  (assert (= (lq Zero Zero) MyFalse))
  (assert (forall ((x Nat)) (= (lq Zero (Succ x)) MyTrue)))
  (assert (forall ((x Nat)) (= (lq (Succ x) Zero) MyFalse)))
  (assert (forall ((y Nat) (x Nat)) (= (lq (Succ x) (Succ y)) (lq x y))))
  (assert (forall ((y Nat) (x Nat)) (= (ite2 MyTrue x y) x)))
  (assert (forall ((y Nat) (x Nat)) (= (ite2 MyFalse x y) y)))
  (assert (forall ((tv10 Nat) (tv9 Nat)) (= (max tv9 tv10) (ite2 (lq tv9 tv10) tv10 tv9))))
  (assert (forall ((x Nat)) (= (plus Zero x) x)))
  (assert (forall ((y Nat) (x Nat)) (= (plus (Succ x) y) (Succ (plus x y)))))
  (assert (forall ((tv14 Nat)) (= (tf3 (Leaf tv14)) Zero)))
  (assert (forall ((tv16 Tree) (tv15 Tree)) (= (tf3 (Node tv15 tv16)) (plus (Succ Zero) (max (tf2 tv15) (tf2 tv16))))))
  (assert (forall ((tv12 Tree)) (= (tf2 tv12) (tf3 tv12))))
  (assert (forall ((tv11 Tree)) (= (depth tv11) (tf2 tv11))))
  (assert (forall ((x Nat)) (= (gq Zero x) MyFalse)))
  (assert (forall ((x Nat)) (= (gq (Succ x) Zero) MyTrue)))
  (assert (forall ((y Nat) (x Nat)) (= (gq (Succ x) (Succ y)) (gq x y))))
  (assert (forall ((x1 Tree) (x0 List)) (= (snd3 (MakeTuple3 x0 x1)) x1)))
  (assert (forall ((x1 Tree) (x0 List)) (= (fst3 (MakeTuple3 x0 x1)) x0)))
  (assert (= (nateq Zero Zero) MyTrue))
  (assert (forall ((x Nat)) (= (nateq Zero (Succ x)) MyFalse)))
  (assert (forall ((x Nat)) (= (nateq (Succ x) Zero) MyFalse)))
  (assert (forall ((y Nat) (x Nat)) (= (nateq (Succ x) (Succ y)) (nateq x y))))
  (assert (forall ((y Tuple3) (x Tuple3)) (= (ite3 MyTrue x y) x)))
  (assert (forall ((y Tuple3) (x Tuple3)) (= (ite3 MyFalse x y) y)))
  (assert (forall ((tv21 Nat) (tv20 Tree)) (= (tf5 tv20 (Leaf tv21)) (MakeTuple3 (Cons tv21 (Nil Null)) tv20))))
  (assert (forall ((tv23 Tree) (tv22 Tree) (tv20 Tree)) (= (tf5 tv20 (Node tv22 tv23)) (ite3 (gq (depth (snd3 (tf4 tv22))) (depth (snd3 (tf4 tv23)))) (MakeTuple3 (fst3 (tf4 tv22)) tv20) (ite3 (nateq (depth (snd3 (tf4 tv22))) (depth (snd3 (tf4 tv23)))) (MakeTuple3 (cat (fst3 (tf4 tv22)) (fst3 (tf4 tv23))) tv20) (MakeTuple3 (fst3 (tf4 tv23)) tv20))))))
  (assert (forall ((tv18 Tree)) (= (tf4 tv18) (tf5 tv18 tv18))))
  (assert (forall ((tv17 Tree)) (= (deepest tv17) (tf4 tv17))))
  (assert (forall ((tv24 Tree)) (= (main tv24) (fst3 (deepest tv24)))))
  (assert (forall ((x1 Nat) (x0 List)) (= (snd4 (MakeTuple4 x0 x1)) x1)))
  (assert (forall ((x1 Nat) (x0 List)) (= (fst4 (MakeTuple4 x0 x1)) x0)))
  (assert (forall ((y Tuple4) (x Tuple4)) (= (ite4 MyTrue x y) x)))
  (assert (forall ((y Tuple4) (x Tuple4)) (= (ite4 MyFalse x y) y)))
  (assert (forall ((tv28 Nat)) (= (tf7 (Leaf tv28)) (MakeTuple4 (Cons tv28 (Nil Null)) Zero))))
  (assert (forall ((tv30 Tree) (tv29 Tree)) (= (tf7 (Node tv29 tv30)) (ite4 (gq (snd4 (tf6 tv29)) (snd4 (tf6 tv30))) (MakeTuple4 (fst4 (tf6 tv29)) (plus (Succ Zero) (snd4 (tf6 tv29)))) (ite4 (nateq (snd4 (tf6 tv29)) (snd4 (tf6 tv30))) (MakeTuple4 (cat (fst4 (tf6 tv29)) (fst4 (tf6 tv30))) (plus (snd4 (tf6 tv29)) (Succ Zero))) (MakeTuple4 (fst4 (tf6 tv30)) (plus (snd4 (tf6 tv30)) (Succ Zero))))))))
  (assert (forall ((tv26 Tree)) (= (tf6 tv26) (tf7 tv26))))
  (assert (forall ((tv25 Tree)) (= (deepestNew tv25) (tf6 tv25))))
  (assert (forall ((tv31 Tree)) (= (mainNew tv31) (fst4 (deepestNew tv31)))))
  (assert (not (forall ((inp0 Tree)) (= (main inp0) (mainNew inp0)))))
  (check-sat)
