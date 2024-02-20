import json

xs_json, xs_name = "cyclegg_res.json", "cyclegg"
ys_json, ys_name = "thesy_res.json", "thesy"

def load(path):
	with open(path, "r") as inp:
		return json.load(inp)

xs_res, ys_res = load(xs_json), load(ys_json)
xs_solved, ys_solved = 0, 0
xs_time, ys_time = [], []

for name, xs_info in xs_res.items():
	if name in ys_res:
		if xs_info["status"]: xs_solved += 1
		if ys_res[name]["status"]: ys_solved += 1
		if xs_info["status"] and ys_res[name]["status"]:
			xs_time.append(xs_info["time"])
			ys_time.append(ys_res[name]["time"])

print(xs_name, xs_solved, None if len(xs_time) == 0 else sum(xs_time) / len(xs_time))
print(ys_name, ys_solved, None if len(ys_time) == 0 else sum(ys_time) / len(ys_time))
