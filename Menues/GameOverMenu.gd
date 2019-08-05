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
	$Menu/TryAgain.connect("pressed", self, "_on_TryAgain_pressed")
	$Menu/ExitToMainMenu.connect("pressed", self, "_on_ExitToMainMenu_pressed")
	$Menu/ExitToDesktop.connect("pressed", self, "_on_ExitToDesktop_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_TryAgain_pressed():
	get_parent().try_again()
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