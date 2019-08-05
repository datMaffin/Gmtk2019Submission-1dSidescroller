extends KinematicBody2D

########################################
# Signals

signal died
signal health_changed(hp)

# Signals
########################################

########################################
# Public Member 

export var max_movement_speed = 10
export var acceleration_speed = 50
export var max_stamina = 5.0
export var stamina_regeneration_speed = 1
export var max_health = 100

# Public Member
######################################## 

########################################
# Private Member 

var movement_speed
var stamina
var health

var teleport_in_last_step = false

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
		if randf() <= 0.5:
			$AudioStreamPlayer1.play()
		else:
			$AudioStreamPlayer2.play()
	
	emit_signal("health_changed", health)
	
	if health == 0:
		emit_signal("died")

# Public Methods
########################################

########################################
# Implementing virtual Methods 

func _ready():
	add_to_group("player")
	
	movement_speed = 0
	stamina = max_stamina
	health = max_health
	
	$Polygon2D.color = Color("33ce2e")
	$Polygon2D.color.a = 1.0
	
	$Actions/TeleportRight.connect("end_pos_reached", self, "_on_Teleport_end_pos_reached")
	$Actions/TeleportLeft.connect("end_pos_reached", self, "_on_Teleport_end_pos_reached")
	
	connect("health_changed", self, "on_Self_health_changed")


func _process(delta):
	
	stamina += delta * stamina_regeneration_speed
	if stamina > max_stamina:
		stamina = max_stamina
	
	var updated_color = calculate_color_for_stamina(stamina, max_stamina)
	updated_color.a = $Polygon2D.color.a
	$Polygon2D.color = updated_color
	
	if Input.is_action_just_pressed("game_teleport_to_right") and consume_stamina_if_enough(1.0):
		$Actions/TeleportRight.start()
	if Input.is_action_just_released("game_teleport_to_right"):
		_on_Teleport_end_pos_reached($Actions/TeleportRight.pos)
		$Actions/TeleportRight.reset()
		
	if Input.is_action_just_pressed("game_teleport_to_left") and consume_stamina_if_enough(1.0):
		$Actions/TeleportLeft.start()
	if Input.is_action_just_released("game_teleport_to_left"):
		_on_Teleport_end_pos_reached($Actions/TeleportLeft.pos)
		$Actions/TeleportLeft.reset()
	
	
	if Input.is_action_just_pressed("game_attack_to_right") and consume_stamina_if_enough(1.0):
		$Actions/MeleeSwoopRight.start()
	if Input.is_action_just_released("game_attack_to_right"):
		var pos = $Actions/MeleeSwoopRight.pos
		$Actions/MeleeSwoopRight.reset()
		
		$Actions/SimpleMeleeRight.execute_attack(pos)
	
	if Input.is_action_just_pressed("game_attack_to_left") and consume_stamina_if_enough(1.0):
		$Actions/MeleeSwoopLeft.start()
	if Input.is_action_just_released("game_attack_to_left"):
		var pos = $Actions/MeleeSwoopLeft.pos
		$Actions/MeleeSwoopLeft.reset()
		
		$Actions/SimpleMeleeLeft.execute_attack(pos)


func _physics_process(delta):
	if not teleport_in_last_step:
		var move_to_right = false
		var move_to_left = false
		
		if Input.is_action_pressed("ui_right"):
			move_to_right = true
		
		if Input.is_action_pressed("ui_left"):
			move_to_left = true
		
		if move_to_left and not move_to_right:
			movement_speed -= delta * acceleration_speed
		elif move_to_right and not move_to_left:
			movement_speed += delta * acceleration_speed
		else:
			if movement_speed < 0:
				movement_speed += delta * acceleration_speed * 0.5
				if movement_speed > 0:
					movement_speed = 0.0
			if movement_speed > 0:
				movement_speed -= delta * acceleration_speed * 0.5
				if movement_speed < 0:
					movement_speed = 0.0
		
		if abs(movement_speed) > max_movement_speed:
			if movement_speed > 0:
				movement_speed = max_movement_speed
			else:
				movement_speed = -max_movement_speed
		
		move_and_collide(Vector2(movement_speed, 0))
	else:
		teleport_in_last_step = false

# Implementing virtual Methods 
########################################

########################################
# Event handler 

func _on_Teleport_end_pos_reached(pos):
	teleport_in_last_step = true
	position.x += pos

func on_Self_health_changed(hp):
	$Polygon2D.color.a = ((health + 50) / (float(max_health) + 50))
	
	if health == 0:
		$Polygon2D.color.a = 0.0

# Event handler
########################################

########################################
# Implementing helper functions 

func consume_stamina_if_enough(s):
	if stamina >= s:
		stamina -= s
		return true
	else:
		return false

func calculate_color_for_stamina(sp, max_sp):
	var green_hue = 140/360.0
	var yellow_hue = 60/360.0
	
	var h = (green_hue - yellow_hue) * (sp / float(max_sp))
	
	return Color.from_hsv(h + yellow_hue, 0.8, 0.9)

# Implementing helper functions 
########################################