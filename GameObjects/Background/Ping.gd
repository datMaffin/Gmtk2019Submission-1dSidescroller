extends Polygon2D

########################################
# Signals
# Signals
########################################

########################################
# Public Member

export var velocity = -800

export(AudioStream) var replace_stream setget set_stream, get_stream

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
	$Area2D.add_to_group("background")
	$Area2D.connect("body_entered", self, "_on_Area2D_body_entered")


func _process(delta):
	position.x += velocity * delta
	
	if position.x > 50000:
		get_parent().remove_child(self)

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_Area2D_body_entered(body):
	if body in get_tree().get_nodes_in_group("player"):
		$AudioStreamPlayer.play()


func set_stream(stream):
	$AudioStreamPlayer.stream = stream


func get_stream():
	return $AudioStreamPlayer.stream

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################