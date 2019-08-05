extends Polygon2D

# Only send when not swooping back!
signal end_pos_reached

# Direction the swoop starts in. if false, its on the left
export var on_right = true

export var start_pos = 100
export var end_pos = 150
export var swoop_back = false

# Only checked when not swooping back!
export var reset_after_end_pos_reached = false
#export var loop = false
export var speed = 100

export var debug_start_immediatly = false

var running = false
var pos = 0
var moving_back = false

# +1 when start pos < end_pos else -1
var forward

func reset():
	running = false
	pos = 0
	moving_back = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_scale(Vector2(0, 1))
	
	if start_pos < end_pos:
		forward = 1
	else:
		forward = -1
	
	if debug_start_immediatly:
		start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if running:
		if not moving_back:
			pos += speed * delta * forward
		else:
			pos -= speed * delta * forward
		
		if forward > 0:
			if pos < start_pos:
				pos = start_pos
				if swoop_back:
					moving_back = not moving_back
				else:
					running = false
			elif pos > end_pos:
				pos = end_pos
				if swoop_back:
					moving_back = not moving_back
				else:
					emit_signal("end_pos_reached", pos)
					if reset_after_end_pos_reached:
						reset()
		else:
			if pos > start_pos:
				pos = start_pos
				if swoop_back:
					moving_back = not moving_back
				else:
					running = false
			elif pos < end_pos:
				pos = end_pos
				if swoop_back:
					moving_back = not moving_back
				else:
					emit_signal("end_pos_reached", pos)
					if reset_after_end_pos_reached:
						reset()
					
	# Update Scale AFTER everything was changed!
	if on_right:
		self.set_scale(Vector2(pos, 1))
	else:
		self.set_scale(Vector2(-pos, 1))


# Start the swoop animation
func start():
	reset()
	
	pos = start_pos
	running = true
	
func end():
	var ret = pos
	reset()
	
	return ret