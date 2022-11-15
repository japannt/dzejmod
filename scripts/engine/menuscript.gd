extends VBoxContainer

onready var hoverPlayer = $buttonHover
onready var clickPlayer = $buttonClick

func buttonHover():
	hoverPlayer.play()

func buttonClick():
	clickPlayer.play()

# SHARED

func _on_exitButton_pressed():
	buttonClick()
	
	get_tree().quit()

# MAIN MENU

func _on_newgameButton_pressed():
	buttonClick()
	
	dzej.switchScene("res://scenes/defaultmap.tscn")

# IN GAME

func _on_resumeButton_pressed():
	buttonClick()
	
	self.get_parent().visible = false
	dzej.lockMouse(true)

func _on_disconnectButton_pressed():
	buttonClick()
	
	dzej.switchScene("res://scenes/engine/backgroundmainmenu.tscn", true)

# MENU TOGGLE

func _input(event):
	if(event.is_action_pressed("ui_cancel")):
		if(self.get_parent().visible):
			self.get_parent().visible = false
			dzej.lockMouse(true)
		else:
			self.get_parent().visible = true
			dzej.lockMouse(false)
