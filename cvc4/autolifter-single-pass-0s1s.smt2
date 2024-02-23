  (declare-datatypes () ((MyBool (MyTrue) (MyFalse))))
  (declare-datatypes () ((Unit (Null))))
  (declare-datatypes () ((List (Cons (proj_Cons_0 MyBool) (proj_Cons_1 List)) (Nil (proj_Nil_0 Unit)))))
  (declare-fun tf1 (List List) List)
  (declare-fun tf0 (List) List)
  (declare-fun tf2 (List) MyBool)
  (declare-fun singlepass (List) MyBool)
  (declare-fun and (MyBool MyBool) MyBool)
  (declare-fun or (MyBool MyBool) MyBool)
  (declare-fun not (MyBool) MyBool)
  (declare-fun ite1 (MyBool MyBool) MyBool)
  (declare-fun tf4 (MyBool List) MyBool)
  (declare-fun tf3 (MyBool List) MyBool)
  (declare-fun zsos (List) MyBool)
  (declare-fun main (List) MyBool)
  (declare-datatypes () ((Nat (Zero) (Succ (proj_Succ_0 Nat)))))
  (declare-datatypes () ((Tuple2 (MakeTuple2 (proj_MakeTuple2_0 MyBool) (proj_MakeTuple2_1 Nat)))))
  (declare-fun fst2 (Tuple2) MyBool)
  (declare-fun nateq (Nat Nat) MyBool)
  (declare-fun snd2 (Tuple2) Nat)
  (declare-fun plus (Nat Nat) Nat)
  (declare-fun ite3 (MyBool Nat Nat) Nat)
  (declare-fun tf6 (List) Tuple2)
  (declare-fun tf5 (List) Tuple2)
  (declare-fun tf7 (List) MyBool)
  (declare-fun singlepassNew (List) MyBool)
  (declare-fun mainNew (List) MyBool)
  (assert (forall ((tv5 Unit) (tv4 List)) (= (tf1 tv4 (Nil tv5)) tv4)))
  (assert (forall ((tv7 List) (tv6 MyBool) (tv4 List)) (= (tf1 tv4 (Cons tv6 tv7)) (Cons tv6 (tf0 tv7)))))
  (assert (forall ((tv2 List)) (= (tf0 tv2) (tf1 tv2 tv2))))
  (assert (forall ((tv9 List)) (= (tf2 tv9) (zsos (tf0 tv9)))))
  (assert (forall ((tv1 List)) (= (singlepass tv1) (tf2 tv1))))
  (assert (forall ((x MyBool)) (= (and MyFalse x) MyFalse)))
  (assert (forall ((true MyBool)) (= (and true MyFalse) MyFalse)))
  (assert (= (and MyTrue MyTrue) MyTrue))
  (assert (forall ((x MyBool)) (= (or MyTrue x) MyTrue)))
  (assert (forall ((false MyBool)) (= (or false MyTrue) MyTrue)))
  (assert (= (or MyFalse MyFalse) MyFalse))
  (assert (= (not MyTrue) MyFalse))
  (assert (= (not MyFalse) MyTrue))
  (assert (forall ((x MyBool)) (= (ite1 MyTrue x) x)))
  (assert (forall ((x MyBool)) (= (ite1 MyFalse x) MyFalse)))
  (assert (forall ((tv15 Unit) (tv14 MyBool)) (= (tf4 tv14 (Nil tv15)) MyTrue)))
  (assert (forall ((tv17 List) (tv16 MyBool) (tv14 MyBool)) (= (tf4 tv14 (Cons tv16 tv17)) (ite1 (or (not tv16) (and tv14 tv16)) (tf3 (and tv14 tv16) tv17)))))
  (assert (forall ((tv12 List) (tv11 MyBool)) (= (tf3 tv11 tv12) (tf4 tv11 tv12))))
  (assert (forall ((tv10 List)) (= (zsos tv10) (tf3 MyTrue tv10))))
  (assert (forall ((tv18 List)) (= (main tv18) (singlepass tv18))))
  (assert (forall ((x1 Nat) (x0 MyBool)) (= (fst2 (MakeTuple2 x0 x1)) x0)))
  (assert (= (nateq Zero Zero) MyTrue))
  (assert (forall ((x Nat)) (= (nateq Zero (Succ x)) MyFalse)))
  (assert (forall ((x Nat)) (= (nateq (Succ x) Zero) MyFalse)))
  (assert (forall ((y Nat) (x Nat)) (= (nateq (Succ x) (Succ y)) (nateq x y))))
  (assert (forall ((x1 Nat) (x0 MyBool)) (= (snd2 (MakeTuple2 x0 x1)) x1)))
  (assert (forall ((x Nat)) (= (plus Zero x) x)))
  (assert (forall ((y Nat) (x Nat)) (= (plus (Succ x) y) (Succ (plus x y)))))
  (assert (forall ((y Nat) (x Nat)) (= (ite3 MyTrue x y) x)))
  (assert (forall ((y Nat) (x Nat)) (= (ite3 MyFalse x y) y)))
  (assert (forall ((tv23 Unit)) (= (tf6 (Nil tv23)) (MakeTuple2 MyTrue Zero))))
  (assert (forall ((tv25 List) (tv24 MyBool)) (= (tf6 (Cons tv24 tv25)) (MakeTuple2 (or (and tv24 (fst2 (tf5 tv25))) (nateq (snd2 (tf5 tv25)) Zero)) (ite3 (not tv24) (snd2 (tf5 tv25)) (plus (Succ Zero) (snd2 (tf5 tv25))))))))
  (assert (forall ((tv21 List)) (= (tf5 tv21) (tf6 tv21))))
  (assert (forall ((tv26 List)) (= (tf7 tv26) (fst2 (tf5 tv26)))))
  (assert (forall ((tv20 List)) (= (singlepassNew tv20) (tf7 tv20))))
  (assert (forall ((tv27 List)) (= (mainNew tv27) (singlepassNew tv27))))
  (assert (not (forall ((inp0 List)) (= (main inp0) (mainNew inp0)))))
  (check-sat)