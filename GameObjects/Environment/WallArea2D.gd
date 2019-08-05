extends Area2D

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
	connect("body_entered", self, "_on_Self_body_entered")

# Implementing virtual Methods 
########################################

########################################
# Event Handler 

func _on_Self_body_entered(body):
	if body in get_tree().get_nodes_in_group("player"):
		body.change_health_by(-1000)
	elif body in get_tree().get_nodes_in_group("enemy"):
		body.change_health_by(-1000)


# Event Handler
########################################

########################################
# Helper Functions 
# Helper Functions 
########################################