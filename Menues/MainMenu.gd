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
	$Menu/Play.connect("pressed", self, "_on_Play_pressed")
	$Menu/Levels.connect("pressed", self, "_on_Levels_pressed")
	$Menu/Exit.connect("pressed", self, "_on_Exit_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_Play_pressed():
	get_parent().start_new_game()
	get_parent().remove_child(self)


func _on_Levels_pressed():
	get_parent().load_level_selector()
	get_parent().remove_child(self)


func _on_Exit_pressed():
	get_tree().quit()

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################