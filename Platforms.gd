extends Timer

export (PackedScene) var Platform

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PLATFORM_SPEED = 700
var PLATFORM_SPAWN_X = 1500
var PLATFORM_DESPAWN_X = -500
var PLATFORM_SPAWN_Y_MAX = 500
var PLATFORM_SPAWN_Y_MIN = 400
var USE_PROGRAM_WAIT_TIME = true
var PROGRAM_WAIT_TIME = 0.6
var STARTING_PLATFORM_SCALE = 3 # times the default platform scale
var NOTE_COUNT = 0 
var NOTES = ["A", "B", "C", "C", "B", "A", "C"]

# Called when the node enters the scene tree for the first time.
func _ready():
	if USE_PROGRAM_WAIT_TIME:
		wait_time = PROGRAM_WAIT_TIME
	var platform = Platform.instance()
	add_child(platform)
	platform.position = Vector2(500,400)
	platform.scale *= STARTING_PLATFORM_SCALE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# manage existing platforms
	for i in get_children():
		i.position.x -= PLATFORM_SPEED*delta
		if i.position.x < PLATFORM_DESPAWN_X:
			i.queue_free()


func _on_Platforms_timeout():
	var platform = Platform.instance()
	add_child(platform)
	platform.position.x = PLATFORM_SPAWN_X
	match(NOTES):
		"A":
			platform.position.y = 400
		"B":
			platform.position.y = 450
		"C":
			platform.position.y = 500
		_:
			platform.position.y = rand_range(PLATFORM_SPAWN_Y_MAX,PLATFORM_SPAWN_Y_MIN)
	if NOTE_COUNT >= NOTES.size():
		NOTE_COUNT = 0
	else:
		NOTE_COUNT = NOTE_COUNT + 1 
	pass # Replace with function body.
