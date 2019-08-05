extends KinematicBody2D

########################################
# Signals

signal health_changed(hp)

# Signals
######################################## 

########################################
# Public Member

export var max_health = 100

# Public Member
######################################## 

########################################
# Private Member

var health

# Private Member
########################################

########################################
# Public Methods

func change_health_by(hp: int):
	health += hp
	if health > max_health:
		health = max_health
	elif health < 0:
		health = 0
	
	if hp < 0.0:
		var rn = randf()
		if rn  <= 0.333:
			$AudioStreamPlayer2D1.play()
		elif rn <= 0.666:
			$AudioStreamPlayer2D2.play()
		else:
			$AudioStreamPlayer2D3.play()
	
	emit_signal("health_changed", health)

# Public Methods
########################################

########################################
# Implementing virtual Methods

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemy")
	
	health = max_health
	
	connect("health_changed", self, "on_Self_health_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Implementing virtual Methods
########################################

########################################
# Event Handler

func on_Self_health_changed(hp):
	$Polygon2D.color.a = ((health + 50) / (float(max_health) + 50))
	
	if hp == 0:
		get_parent().remove_child(self)

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################