extends Node2D

# Notes:
# Goal of this level: Learn jumping/teleporting

########################################
# Signals

signal level_finished
signal game_over

# Signals
########################################

########################################
# Public Member
# Public Member
######################################## 

########################################
# Private Member

var execute_next_physics = []
var last_checkpoint_x = 0

enum CurrentPing {NORMAL, NONE}
var current_ping = CurrentPing.NORMAL

var projectile_attack

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
	$LearnDisappear/HugeWall2/Timer.connect("timeout", self, "_on_HugeWall2_Timer_timeout")
	
	$LearnButton/AbstractButton.connect("body_entered", self, "_on_AbstractButton_body_entered")
	$LearnButton/AbstractButton/HugeWall3/Timer.connect("timeout", self, "_on_HugeWall3_Timer_timeout")
	
	$LearnButton/AbstractButton2.connect("body_entered", self, "_on_LBAbstractButton2_body_entered")
	
	$AbstractButton2.connect("body_entered", self, "_on_AbstractButton2_body_entered")
	
	$WaitingForThxTimer.connect("timeout", self, "_on_WaitingForThxTimer_timeout")
	
	get_tree().get_nodes_in_group("player")[0].connect("died", self, "_on_Player_died")
	
	$LearnDisappear/BigWall/Timer.connect("timeout", self, "_on_BigWall_Timer_timeout")
	$LearnDisappear/BigWall4/Timer.connect("timeout", self, "_on_BigWall4_Timer_timeout")
	
	# All checkpoints
	$LearnToJump/AbstractCheckpoint.connect("body_entered", self, "_on_Checkpoint_body_entered")
	$LearnToJump/AbstractCheckpoint2.connect("body_entered", self, "_on_Checkpoint_body_entered")
	$LearnToJump/AbstractCheckpoint3.connect("body_entered", self, "_on_Checkpoint_body_entered")
	$LearnDisappear/AbstractCheckpoint.connect("body_entered", self, "_on_Checkpoint_body_entered")
	$LearnButton/AbstractCheckpoint.connect("body_entered", self, "_on_Checkpoint_body_entered")
	
	$LearnButton/Dummy2/Timer.connect("timeout", self, "_on_DummyTimer_timeout")
	projectile_attack = preload("res://GameObjects/Attacks/Ranged/ProjectileAttack.tscn")


func _process(delta):
	$Background/PingSpawner.global_position.x = min($Player.global_position.x + 6000, $AbstractButton2/Polygon2D2.global_position.x)
	if current_ping == CurrentPing.NORMAL and $Player.global_position.x + 2000 > $AbstractButton2/Polygon2D2.global_position.x:
		$Background/PingSpawner.stop_sos()
		current_ping = CurrentPing.NONE
	# TODO: change sound depending on distance

func _physics_process(delta):
	while execute_next_physics.size():
		call(execute_next_physics.pop_front())

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_DummyTimer_timeout():
	var pa = projectile_attack.instance()
	pa.position.x = -100
	$LearnButton/Dummy2.add_child(pa)

func _on_HugeWall2_Timer_timeout():
	execute_next_physics.append("flip_disabled_HugeWall2")


func _on_BigWall_Timer_timeout():
	execute_next_physics.append("flip_disabled_BigWall")

func _on_BigWall4_Timer_timeout():
	execute_next_physics.append("flip_disabled_BigWall4")


func _on_AbstractButton_body_entered(body):
	execute_next_physics.append("disable_HugeWall3")
	$LearnButton/AbstractButton/HugeWall3/Timer.start()

func _on_HugeWall3_Timer_timeout():
	execute_next_physics.append("enable_HugeWall3")


func _on_LBAbstractButton2_body_entered(body):
	execute_next_physics.append("disable_LBAB2_HugeWall3")


func _on_AbstractButton2_body_entered(body):
	execute_next_physics.append("disable_cell")
	
	get_tree().call_group("pings", "thx") # stop sos pinging and message thx
	
	$AbstractButton2.disconnect("body_entered", self, "_on_AbstractButton2_body_entered")
	
	$WaitingForThxTimer.start()


func _on_WaitingForThxTimer_timeout():
	emit_signal("level_finished")

func _on_Checkpoint_body_entered(body):
	last_checkpoint_x = body.global_position.x

func _on_Player_died():
	# Teleport back to last checkpoint
	get_tree().get_nodes_in_group("player")[0].global_position.x = last_checkpoint_x
	get_tree().get_nodes_in_group("player")[0].movement_speed = 0.0
	get_tree().get_nodes_in_group("player")[0].stamina = 	get_tree().get_nodes_in_group("player")[0].max_stamina
	get_tree().get_nodes_in_group("player")[0].health = 	get_tree().get_nodes_in_group("player")[0].max_health
	get_tree().get_nodes_in_group("player")[0].change_health_by(0.0)

# Event Handler
########################################

########################################
# Helper Functions

func flip_disabled_HugeWall2():
	$LearnDisappear/HugeWall2.disabled = not $LearnDisappear/HugeWall2.disabled
	
func flip_disabled_BigWall():
	$LearnDisappear/BigWall.disabled = not $LearnDisappear/BigWall.disabled

func flip_disabled_BigWall4():
	$LearnDisappear/BigWall4.disabled = not $LearnDisappear/BigWall4.disabled

func disable_HugeWall3():
	$LearnButton/AbstractButton/HugeWall3.disabled = true

func enable_HugeWall3():
	$LearnButton/AbstractButton/HugeWall3.disabled = false

func disable_LBAB2_HugeWall3():
	$LearnButton/AbstractButton2/HugeWall3.disabled = true


func disable_cell():
	$AbstractButton2/SmallWall.disabled = true
	$AbstractButton2/SmallWall2.disabled = true
	$AbstractButton2/SmallWall3.disabled = true
	$AbstractButton2/SmallWall4.disabled = true
	$AbstractButton2/SmallWall5.disabled = true
	$AbstractButton2/SmallWall6.disabled = true
	$AbstractButton2/SmallWall7.disabled = true
	$AbstractButton2/SmallWall8.disabled = true
	$AbstractButton2/SmallWall9.disabled = true
	$AbstractButton2/SmallWall10.disabled = true
	$AbstractButton2/SmallWall11.disabled = true
	$AbstractButton2/SmallWall12.disabled = true
	$AbstractButton2/SmallWall13.disabled = true
	$AbstractButton2/SmallWall14.disabled = true
	$AbstractButton2/SmallWall15.disabled = true
	$AbstractButton2/SmallWall16.disabled = true

# Helper Functions
########################################