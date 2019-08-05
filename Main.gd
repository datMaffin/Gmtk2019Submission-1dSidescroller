extends Node

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

var main_menu
var pause_menu
var game_over_menu

var current_menu_instance
var current_level
var current_level_instance

# Private Member
########################################

########################################
# Public Methods

# func start_level(id):
#	pass

func load_main_menu():
	get_tree().paused = false
	add_child(main_menu.instance())

func load_level_selector():
	add_child(preload("res://Menues/LevelSelector.tscn").instance())


func start_new_game():
	current_level = preload("res://Levels/ALevel.tscn")
	current_level_instance = current_level.instance()
	current_level_instance.connect("level_finished", self, "level_finished")
	current_level_instance.connect("game_over", self, "game_over")
	add_child(current_level_instance)


func try_again():
	current_level_instance = current_level.instance()
	current_level_instance.connect("level_finished", self, "level_finished")
	current_level_instance.connect("game_over", self, "game_over")
	add_child(current_level_instance)


func continue_game():
	add_child(current_level_instance)
	get_tree().paused = false


func level_finished():
	remove_child(current_level_instance)
	add_child(main_menu.instance())
	$AcceptDialog.popup_centered()
	


func game_over():
	# TODO: Checkpoints?
	current_level_instance.disconnect("level_finished", self, "level_finished")
	current_level_instance.disconnect("game_over", self, "game_over")

	remove_child(current_level_instance)
	add_child(game_over_menu.instance())
	

# Public Methods
########################################

########################################
# Implementing virtual Methods

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("main")
	
	main_menu = preload("res://Menues/MainMenu.tscn")
	pause_menu = preload("res://Menues/PauseMenu.tscn")
	game_over_menu = preload("res://Menues/GameOverMenu.tscn")
	
	add_child(main_menu.instance())
	
	
	

func _process(delta):
	if Input.is_action_just_released("game_pause") and current_level_instance in get_children() :
		if not get_tree().paused:
			get_tree().paused = true
			remove_child(current_level_instance)
			add_child(pause_menu.instance())

# Implementing virtual Methods
########################################

########################################
# Event Handler
# Event Handler
########################################

########################################
# Helper Functions

# Helper Functions
########################################