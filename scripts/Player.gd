extends Node2D



# Declare member variables here. Examples:
var SPAWN_POSITION = Vector2(400,300)
var SPAWN_VEL = Vector2(0,-20)
var GRAVITY = Vector2(0,100)
var JUMP = Vector2(0,-1300)
var ACC_FALL = Vector2(0,100)
var GROUND_SPEED_FWD = Vector2(600,0)
var AIR_SPEED_FWD = Vector2(500,0)
var GROUND_SPEED_BWD = Vector2(800,0)
var AIR_SPEED_BWD = Vector2(700,0)
var UP = Vector2(0,-1)
var VEL_TERMINAL = 1600
var SCREEN_BOTTOM = 700
var CHANCE_TIME = 0.1

# var a = 2
# var b = "text"
var move_vector = Vector2(0,0)
var jumps = 2
var deaths = 0

func _ready():
	$KinematicBody2D.position = SPAWN_POSITION
	move_vector = SPAWN_VEL
	display_labels()
	

func _process(delta):
	display_labels()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Read inputs
	
	
	if $KinematicBody2D.is_on_floor():
		set_jumps()
		move_vector.y = 0
	if $KinematicBody2D.is_on_ceiling():
		move_vector.y = 0
	move_vector += GRAVITY
	if Input.is_action_just_pressed("ui_up"):
		if jumps >0:
			move_vector=JUMP
			jumps-=1
		pass
	if Input.is_action_pressed("ui_down"):
		if $KinematicBody2D.is_on_floor():
			Crouch()
		else:
			move_vector+= ACC_FALL
		pass
	move_vector.x = 0 #no compounding horizontal velocity.
	if Input.is_action_pressed("ui_left"):
		if $KinematicBody2D.is_on_floor():
			move_vector-=GROUND_SPEED_BWD
		else:
			move_vector-=AIR_SPEED_BWD
		pass
	if Input.is_action_pressed("ui_right"):
		if $KinematicBody2D.is_on_floor():
			move_vector+=GROUND_SPEED_FWD
		else:
			move_vector+=AIR_SPEED_FWD
		pass
	if move_vector.y>VEL_TERMINAL:
		move_vector.y = VEL_TERMINAL
	elif move_vector.y < -VEL_TERMINAL:
		move_vector.y = -VEL_TERMINAL
	# Calculate Velocity
	$KinematicBody2D.move_and_slide(move_vector,UP)
		
	# Check if off screen
	if $KinematicBody2D.position.y > SCREEN_BOTTOM:
		if $DeathTimer.is_stopped():
			$DeathTimer.start(CHANCE_TIME)
	else:
		$DeathTimer.stop()
	pass

func Crouch():
	pass
	
func on_death():
	$KinematicBody2D.position = SPAWN_POSITION
	move_vector = SPAWN_VEL
	deaths+=1
	set_jumps()
	
func set_jumps():
	jumps = 2

func display_labels():
	$Deaths.text = "Deaths = " + str(deaths)
	$Jumps.text = "Jumps = " + str(jumps)


