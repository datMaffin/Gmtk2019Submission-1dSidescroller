extends StaticBody2D

########################################
# Public Member 

export var disabled = false setget set_disabled, get_disabled

# Public Member
######################################## 

########################################
# Private Member 
# Private Member 
########################################

########################################
# Public Methods 
# Public Methods
########################################

########################################
# Implementing virtual Methods

func _ready():
	add_to_group("wall")
	add_to_group("environment")

# Implementing virtual Methods 
########################################

########################################
# Event Handler 

func set_disabled(d: bool):
	$CollisionShape2D.set_disabled(d)
	$WallArea2D/CollisionShape2D.set_disabled(d)
	
	if d:
		$Polygon2D.color.a = 0.1
	else:
		$Polygon2D.color.a = 1


func get_disabled():
	return $WallArea2D/CollisionShape2D.disabled

# Event Handler
########################################

########################################
# Helper Functions 
# Helper Functions 
########################################