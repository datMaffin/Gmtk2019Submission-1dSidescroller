extends Node2D

########################################
# Public Member

export var damage = 10
export var distance = 100
export var duration = 0.5

enum DamageTo {PLAYER = 1, ENEMY = 2, BOTH = 3}
export(DamageTo) var damage_to = DamageTo.BOTH setget set_damage_to, get_damage_to

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

func execute_attack(dist = distance, dmg = damage, dur = duration):
	$Polygon2D.polygon = PoolVector2Array([Vector2(0, 0.0), Vector2(0, 500.0), Vector2(dist, 500.0), Vector2(dist, 0.0)])
	
	$AbstractMeleeAttack/CollisionShape2D.shape.set_extents(Vector2(dist / 2.0, 250))
	$AbstractMeleeAttack/CollisionShape2D.transform = Transform2D(0.0, Vector2(dist / 2.0, 250))
	
	$AbstractMeleeAttack.damage = dmg
	
	$Timer.start(dur)
	
	self.visible = true
	$AbstractMeleeAttack/CollisionShape2D.set_disabled(false)

# Public Methods
########################################

########################################
# Implementing virtual Methods

# Called when the node enters the scene tree for the first time.
func _ready():
	$AbstractMeleeAttack/CollisionShape2D.set_disabled(true)
	self.visible = false
	
	$Timer.connect("timeout", self, "_on_Timer_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_Timer_timeout():
	$AbstractMeleeAttack/CollisionShape2D.set_disabled(true)
	self.visible = false


func set_damage_to(to):
	$AbstractMeleeAttack.damage_to = to


func get_damage_to():
	return $AbstractMeleeAttack.damage_to

# Event Handler
########################################

########################################
# Helper Functions

# Helper Functions
########################################