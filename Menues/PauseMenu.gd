extends Control

########################################
# Signals
# Signals
########################################

########################################
# Public Member
# Public Member
######################################## 

########################################
# Private Member

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Private Member
########################################

########################################
# Public Methods
# Public Methods
########################################

########################################
# Implementing virtual Methods


func _ready():
	$Menu/Continue.connect("pressed", self, "_on_Continue_pressed")
	$Menu/ExitToMainMenu.connect("pressed", self, "_on_ExitToMainMenu_pressed")
	$Menu/ExitToDesktop.connect("pressed", self, "_on_ExitToDesktop_pressed")


func _process(delta):
	if Input.is_action_just_released("game_pause"):
		_on_Continue_pressed()

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_Continue_pressed():
	get_parent().continue_game()
	get_parent().remove_child(self)


func _on_ExitToMainMenu_pressed():
	get_parent().load_main_menu()
	get_parent().remove_child(self)


func _on_ExitToDesktop_pressed():
	get_tree().quit()

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################