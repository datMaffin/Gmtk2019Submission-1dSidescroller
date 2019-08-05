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

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", self, "_on_Button_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_Button_pressed():
	get_parent().load_main_menu()
	get_parent().remove_child(self)

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################