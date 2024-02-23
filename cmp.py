import json
import os

def load(path):
	with open(path, "r") as inp:
		return json.load(inp)

res_dir = "proof_res"
def compare(xname, yname):
	xs_res, ys_res = load(os.path.join(res_dir, xname + "_res.json")), load(os.path.join(res_dir, yname + "_res.json"))
	xs_solved, ys_solved = 0, 0
	xs_time, ys_time = [], []

	for name, xs_info in xs_res.items():
		if xs_info["status"]: xs_solved += 1
		if name in ys_res:
			if ys_res[name]["status"]: ys_solved += 1
			if xs_info["status"] and ys_res[name]["status"]:
				xs_time.append(xs_info["time"])
				ys_time.append(ys_res[name]["time"])
	print("\ncompare", xname, "with", yname)
	print("%7s %3d %.3f" % (xname, xs_solved, -1 if len(xs_time) == 0 else sum(xs_time) / len(xs_time)))
	print("%7s %3d %.3f" % (yname, ys_solved, -1 if len(ys_time) == 0 else sum(ys_time) / len(ys_time)))
	print(sorted(ys_time))

compare("cyclegg", "thesy")
compare("cyclegg", "hipspec")
compare("cyclegg", "cvc5")