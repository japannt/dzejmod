extends Node

enum {
	ARG_INT,
	ARG_FLOAT,
	ARG_STRING,
	ARG_BOOL,
	ARG_NULL
}

const valid = [
	["help", [ARG_NULL]],
	["echo", [ARG_STRING]],
	["version", [ARG_NULL]],

	["sv_map", [ARG_STRING]],
	["sv_phys_fps", [ARG_FLOAT]],

	["cl_getvar" [ARG_STRING]],
	["cl_hello", [ARG_NULL]]
]

# SV

func sv_phys_fps(fps):
	#does not wurk!! :sob:
	#yet! try save_custom() and set_settings() at map loading !!!!
	ProjectSettings.set_setting("physics/common/physics_fps", fps)
	ProjectSettings.save()
	return ProjectSettings.get_setting("physics/common/physics_fps")

func sv_map(map):
	dzej.msg("attemting to load map: " + map)

	dzej.targetScene = "scenes/" + map

	if(!ResourceLoader.exists(dzej.targetScene)):
		dzej.msg("[ERROR] scene " + dzej.targetScene + " does not exist")
		return false

	var out = dzej.switchScene("res://scenes/engine/GameplayWorld.tscn")
	if(typeof(out) == TYPE_STRING && out == false):
		dzej.msg("error loading map: " + map)
		return false
	else:
		dzej.msg("map loaded: " + map)
		return true
# CL

func cl_hello():
	return "hello dzejmod console"

func cl_getvar(varname):
	return str(get(varname))

# GENERAL

func version():
	return "dzejmod 0.0.0 development version Work in progress.\n(DC) japannt#7318\n(TG) @japannt"

func echo(text):
	return text

func help():
	var output : String
	for each in valid:
#		print(each)
		for i in each:
			#print(current)
			if i[0] is int:
				output += "\t"
				match i[0]:
					ARG_NULL:
						output += each[0]
					ARG_STRING:
						output += each[0] + " [string]"
					ARG_INT:
						output += each[0] + " [int]"
					ARG_FLOAT:
						output += each[0] + " [float]"
					_:
						output += "Value not implemented..."
				output += "\n"
	return output
