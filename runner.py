import os 
from tqdm import tqdm
from cache import *
import time

timeout = 120

def switch_dir(path, output_path):
	file_name = os.path.basename(path)
	return os.path.join(output_path, file_name)

def create_path(file):
	dir_path = os.path.dirname(file)
	os.makedirs(dir_path, exist_ok=True)

def split_suffix(file):
	names = file.split(".")
	return ".".join(names[:-1]), names[-1]

dataset_root = "/root/ISTool/runner/"
output_root = os.path.join(dataset_root, "proof_res")
cyclegg_path = "/root/cyclegg/"
thesy_path = "/root/TheSy/"
hipspec_path = "/root/hipspec/hipspec"

def run_cyclegg(task_name, output_path):
	oup_file = switch_dir(task_name, output_path) + ".out"
	inp_file = task_name + ".ceg"
	create_path(oup_file)
	command = ["cd", cyclegg_path, ";", "timeout " + str(timeout), "cargo run --package cyclegg --bin cyclegg --release  --", inp_file, ">", oup_file, "2>/dev/null"]
	command = " ".join(command)
	os.system(command)

	with open(oup_file, "r") as res:
		line = "\n".join(res.readlines())
	if "Property accepted by cvec analysis" not in line and "overflow" not in line:
		print(command)
		print("Incorrect translation ", os.path.basename(task_name))
	
	if " VALID (" in line:
		ti = line.split(" VALID (")[1].split(" ms)")[0]
		return True, float(ti) / 1000
	return False, None 

def run_hipspec(task_name, output_path):
	oup_file = switch_dir(task_name, output_path) + ".out"
	inp_file = task_name + ".hs"
	moved_inp_file = switch_dir(inp_file, hipspec_path)
	os.system("cp " + inp_file + " " + moved_inp_file)
	task_name = os.path.basename(inp_file)
	create_path(oup_file)
	command = ["cd", hipspec_path, ";", "timeout " + str(timeout), "stack-1.9.3 exec hipspec --", task_name, "--auto --verbosity=85 --pvars --size 7 --cg -luU", ">", oup_file, "2>/dev/null"]
	command = " ".join(command)
	start_time = time.time()
	os.system(command)
	end_time = time.time()
	os.system("rm " + moved_inp_file)

	with open(oup_file, "r") as res:
		line = "\n".join(res.readlines())
	if "File processed." not in line:
		print(command)
		print("Incorrect translation ", os.path.basename(task_name))
	
	if "Proved optimize" in line:
		return True, end_time - start_time
	return False, None 

def run_cvc5(task_name, output_path):
	oup_file = switch_dir(task_name, output_path) + ".out"
	inp_file = task_name + ".smt2"
	create_path(oup_file)
	
	command = ["timeout " + str(timeout), "cvc5 --quant-ind ", inp_file, ">", oup_file, "2>/dev/null"]
	command = " ".join(command)
	start_time = time.time()
	os.system(command)
	end_time = time.time()

	with open(oup_file, "r") as res:
		line = "\n".join(res.readlines())
	line = "".join(filter(lambda char: not char.isspace(), line))

	if len(line) == 0 or line == "unknown":
		return False, None 
	if line == "sat":
		print(command)
		print("Invalid property", os.path.basename(task_name))
	if line == "unsat":
		return True, end_time - start_time
	print(command)
	print("Unexpected output", line, os.path.basename(task_name))

def run_thesy(file, output_path):
	oup_file = switch_dir(file, output_path) + ".out"
	json_file = switch_dir(file, output_path) + ".stats.json"
	inp_file = file + ".th"
	create_path(oup_file)
	if os.path.exists(json_file): os.system("rm " + json_file)
	command = ["cd", thesy_path, ";", "timeout " + str(timeout), "cargo run --release --features \"stats\" -- --prove ", inp_file, ">", oup_file, "2>/dev/null"]
	command = " ".join(command)

	os.system(command)
	
	inp_dir = os.path.dirname(file)
	task_base = os.path.basename(file)
	for new_file in os.listdir(inp_dir):
		if task_base + "." in new_file and new_file != task_base + ".th":
			os.rename(os.path.join(inp_dir, new_file), os.path.join(output_path, new_file))

	if not os.path.exists(json_file): return False, None 

	with open(json_file, "r") as inp:
		res = json.load(inp)

	if len(res["goals_proved"]) == 0: 
		print(res)
		return False, None
	return True, res["total_time"]["secs"] + res["total_time"]["nanos"] * (10 ** -9)

#my_res = load_cache(os.path.join(output_root, "cyclegg_res.json"))
#solved_tasks = []
#for name, status in my_res.items():
#	if status["status"]: solved_tasks.append(name)

def run(exp_name, dataset_name, runner, expected_suffix):
	all_files = []
	dataset_path = os.path.join(dataset_root, dataset_name)
	output_path = os.path.join(output_root, exp_name)
	cache_path = os.path.join(output_root, exp_name + "_res.json")
	for file in os.listdir(dataset_path):
		if "." not in file: continue
		name, suffix = split_suffix(file)
		#if name not in solved_tasks: continue
		if suffix != expected_suffix: continue
		all_files.append(os.path.join(dataset_path, name))
	
	cache = load_cache(cache_path)
	is_cover = False 

	print("run exp", exp_name)
	for file in tqdm(all_files):
		name = os.path.basename(file)
		if name in cache: continue
		status, ti = runner(file, output_path)
		if status:
			cache[name] = {"status": True, "time": ti}
		else:
			cache[name] = {"status": False}
		save_cache(cache_path, cache, is_cover)
		is_cover = True

run("cyclegg", "ceg", run_cyclegg, "ceg")
run("thesy", "th", run_thesy, "th")
run("hipspec", "hip", run_hipspec, "hs")
run("cvc5", "cvc5", run_cvc5, "smt2")