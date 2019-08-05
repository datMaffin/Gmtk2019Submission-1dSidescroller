extends Node2D

########################################
# Signals
# Signals
########################################

########################################
# Public Member

export(AudioStream) var replace_stream
export(AudioStream) var thx_sound_stream
export var ping_timing = [0.2, 0.2, 0.2, 0.8, 0.8, 0.8, 0.2, 0.2, 20.0]
export var ping_sequence= ["s", "s", "s", "l", "l", "l", "s", "s", "s"]
export var time_interval = 15

# Public Member
######################################## 

########################################
# Private Member

var short_ping_preloaded
var long_ping_preloaded

var next_ping_id

# Private Member
########################################

########################################
# Public Methods

func stop_sos():
	$Timer.stop()
	$Timer.disconnect("timeout", self, "_on_Timer_timeout")


func thx():
	$Timer.stop()
	ping_timing = [0.8, 0.2, 0.2, 0.2, 0.2, 0.8, 0.2, 0.2, 10]
	ping_sequence = ["l", "s", "s", "s", "s", "l", "s", "s", "l"]
	next_ping_id = 0
	if thx_sound_stream:
		replace_stream = thx_sound_stream
	$OldTimer.start(0.5)


# Public Methods
########################################

########################################
# Implementing virtual Methods

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("pings")
	
	short_ping_preloaded = preload("res://GameObjects/Background/ShortPing.tscn")
	long_ping_preloaded = preload("res://GameObjects/Background/LongPing.tscn")
	
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$OldTimer.connect("timeout", self, "_on_OldTimer_timeout")
	
	$Timer.start(0.5)


func _process(delta):
	pass

# Implementing virtual Methods
########################################

########################################
# Event Handler

func _on_OldTimer_timeout():
	var ping
	if ping_sequence[next_ping_id] == "s":
		ping = short_ping_preloaded.instance()
	else:
		ping = long_ping_preloaded.instance()
	
	if replace_stream:
		ping.set_stream(replace_stream)
	
	add_child(ping)
	
	$OldTimer.start(ping_timing[next_ping_id])
	
	next_ping_id += 1
	if next_ping_id >= ping_sequence.size():
		next_ping_id = 0


func _on_Timer_timeout():
	var ping
	var timing = 0
	for i in range(ping_timing.size()):
		if ping_sequence[i] == "s":
			ping = short_ping_preloaded.instance()
		else:
			ping = long_ping_preloaded.instance()
		
		ping.global_position.x = global_position.x + timing
		
		timing += ping_timing[i] * ping.velocity * -1
		
		if replace_stream:
			ping.set_stream(replace_stream)
		
		get_parent().add_child(ping)  # needs to be in a separate group to force the sounds to be in the background
		
	$Timer.start(time_interval)

# Event Handler
########################################

########################################
# Helper Functions
# Helper Functions
########################################