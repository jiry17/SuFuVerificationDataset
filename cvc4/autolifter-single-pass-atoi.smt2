  (declare-datatypes () ((MyBool (MyTrue) (MyFalse))))
  (declare-datatypes () ((Nat (Zero) (Succ (proj_Succ_0 Nat)))))
  (declare-datatypes () ((Unit (Null))))
  (declare-datatypes () ((List (Cons (proj_Cons_0 Nat) (proj_Cons_1 List)) (Nil (proj_Nil_0 Unit)))))
  (declare-fun tf1 (List List) List)
  (declare-fun tf0 (List) List)
  (declare-fun tf2 (List) Nat)
  (declare-fun singlepass (List) Nat)
  (declare-fun plus (Nat Nat) Nat)
  (declare-fun times (Nat Nat) Nat)
  (declare-fun tf4 (List) Nat)
  (declare-fun tf3 (List) Nat)
  (declare-fun atoi (List) Nat)
  (declare-fun main (List) Nat)
  (declare-fun tf6 (List) Nat)
  (declare-fun tf5 (List) Nat)
  (declare-fun tf7 (List) Nat)
  (declare-fun singlepassNew (List) Nat)
  (declare-fun mainNew (List) Nat)
  (assert (forall ((tv5 Unit) (tv4 List)) (= (tf1 tv4 (Nil tv5)) tv4)))
  (assert (forall ((tv7 List) (tv6 Nat) (tv4 List)) (= (tf1 tv4 (Cons tv6 tv7)) (Cons tv6 (tf0 tv7)))))
  (assert (forall ((tv2 List)) (= (tf0 tv2) (tf1 tv2 tv2))))
  (assert (forall ((tv9 List)) (= (tf2 tv9) (atoi (tf0 tv9)))))
  (assert (forall ((tv1 List)) (= (singlepass tv1) (tf2 tv1))))
  (assert (forall ((x Nat)) (= (plus Zero x) x)))
  (assert (forall ((y Nat) (x Nat)) (= (plus (Succ x) y) (Succ (plus x y)))))
  (assert (forall ((x Nat)) (= (times Zero x) Zero)))
  (assert (forall ((y Nat) (x Nat)) (= (times (Succ x) y) (plus (times x y) y))))
  (assert (forall ((tv13 Unit)) (= (tf4 (Nil tv13)) Zero)))
  (assert (forall ((tv15 List) (tv14 Nat)) (= (tf4 (Cons tv14 tv15)) (plus (times (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))))) (tf3 tv15)) tv14))))
  (assert (forall ((tv11 List)) (= (tf3 tv11) (tf4 tv11))))
  (assert (forall ((tv10 List)) (= (atoi tv10) (tf3 tv10))))
  (assert (forall ((tv16 List)) (= (main tv16) (singlepass tv16))))
  (assert (forall ((tv21 Unit)) (= (tf6 (Nil tv21)) Zero)))
  (assert (forall ((tv23 List) (tv22 Nat)) (= (tf6 (Cons tv22 tv23)) (plus tv22 (times (tf5 tv23) (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))))))))))
  (assert (forall ((tv19 List)) (= (tf5 tv19) (tf6 tv19))))
  (assert (forall ((tv24 List)) (= (tf7 tv24) (tf5 tv24))))
  (assert (forall ((tv18 List)) (= (singlepassNew tv18) (tf7 tv18))))
  (assert (forall ((tv25 List)) (= (mainNew tv25) (singlepassNew tv25))))
  (assert (not (forall ((inp0 List)) (= (main inp0) (mainNew inp0)))))
  (check-sat)
