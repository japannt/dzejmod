extends WindowDialog

onready var inputBox = $VBoxContainer/LineEdit
onready var outputBox = $VBoxContainer/TextEdit

onready var dzejref = weakref(dzej)

func _ready():
	outText("Dzejmod " + dzej.VERSION + "\nBy TEAM DZEJMOD. https://dzejmod.tk")
	outText("[INFO] engine initalizing...")
	outText("[INFO] console loaded")

func _on_LineEdit_text_entered(new_text):
	outText(new_text)
	inputBox.clear()

	parseCommand(new_text)

func outText(text):
	if(outputBox != null):
		if(typeof(text) == TYPE_STRING):
			outputBox.text += text + "\n"
		else:
			outputBox.text += str("command returned: ", text) + "\n"
		outputBox.set_v_scroll(outputBox.get_v_scroll() + 100000)
		return true
	else:
		return false

func checkType(string, type):
	if type == con.ARG_INT:
		return string.is_valid_integer()
	if type == con.ARG_FLOAT:
		return string.is_valid_float()
	if type == con.ARG_STRING:
		return true
	if type == con.ARG_BOOL:
		return (string == "true" or string == "false")
	if type == con.NULL:
		return true
	return false

func parseCommand(text):
	var words = text.split(" ")
	words = Array(words)
	
	for _i in range(words.count("")):
		words.erase("")
	
	if words.size() == 0:
		return
	
	var command_word = words.pop_front()
	
	for c in con.valid:
		if c[0] == command_word:
			if(words.size() != c[1].size() && c[1] != [con.ARG_NULL]):
				outText(str('Failure executing command "', command_word, '", expected ', c[1].size(), ' parameters'))
				return
			for i in range(words.size()):
				if not checkType(words[i], c[1][i]):
					outText(str('Failure executing command "', command_word, '", parameter ', (i + 1), ' ("', words[i], '") is of the wrong type'))
					return
			outText(con.callv(command_word, words))
			return
	outText(str('Command "', command_word, '" does not exist.'))

# CONSOLE TOGGLE

func _input(event):
	if(event.is_action_pressed("engine_console")):
		if(!self.is_visible()):
			self.popup()
		else:
			self.hide()


func consoleClose():
	if dzejref.get_ref():
		dzej.lpMouseLock(true)

func consoleOpen():
	dzej.lpMouseLock(false)
