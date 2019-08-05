extends Area2D

########################################
# Signals
# Signals
########################################

########################################
# Public Member

export var velocity = 20
export var damage = 50

enum DamageTo {PLAYER = 1, ENEMY = 2, BOTH = 3}
export(DamageTo) var damage_to = DamageTo.PLAYER

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
	connect("area_entered", self, "_on_Self_area_entered")
	connect("body_entered", self, "_on_Self_body_entered")

func _process(delta):
	position.x += velocity * delta

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_Self_area_entered(area):
	#if area in get_tree().get_nodes_in_group("wall"):
	if not (area in get_tree().get_nodes_in_group("background")):
		get_parent().remove_child(self)

func _on_Self_body_entered(body):
	if body in get_tree().get_nodes_in_group("player") and (damage_to == DamageTo.PLAYER or damage_to == DamageTo.BOTH):
		body.change_health_by(-damage)
	elif body in get_tree().get_nodes_in_group("enemy") and (damage_to == DamageTo.ENEMY or damage_to == DamageTo.BOTH):
		body.change_health_by(-damage)

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################