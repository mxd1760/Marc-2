extends Node2D

# Constant variables
export var SPAWN_POSITION = Vector2(400,300)
export var SPAWN_VEL = Vector2(0,-20)
export var GRAVITY = Vector2(0,100)
export var JUMP = Vector2(0,-1300)
export var ACC_FALL = Vector2(0,100)
export var GROUND_SPEED_FWD = Vector2(600,0)
export var AIR_SPEED_FWD = Vector2(500,0)
export var GROUND_SPEED_BWD = Vector2(800,0)
export var AIR_SPEED_BWD = Vector2(700,0)
export var UP = Vector2(0,-1)
export var VEL_TERMINAL = 1600
export var SCREEN_BOTTOM = 700
export var CHANCE_TIME = 0.1
export var GRAPPLE_STORAGE_POSITION = Vector2(150,-150)
export var GRAPPLE_VELOCITY = Vector2(1250,-1000) # for the grapple when flying through the air
export var GRAPPLED_VELOCITY = Vector2(-700,-10) # for when the grapple is attached to a wall (the x should probably match up with plaftorm speed)
export var GRAPPLE_LAUNCH_OFFSET = Vector2(0,0)#Vector2(50,-50)
export var STORED_JUMPS = 2
export var MAX_DEATHS = 5

# Member variables
var move_vector = Vector2(0,0)
var jumps = STORED_JUMPS
var deaths = 0
var grappling = false
var grappled = false
var grapple_vector = Vector2(0,0)
var grapple_offset = Vector2(0,0)
var grapple_radius = 0
var phys_paused = false
var demo = false

# Signals
signal Game_Over

func _ready():
	$Body.position = SPAWN_POSITION
	$Grapple.position = GRAPPLE_STORAGE_POSITION
	grappling = false
	move_vector = SPAWN_VEL
	display_labels()
	

func _process(delta):
	display_labels()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Calculate state
	if not phys_paused:
		if $Body.is_on_floor():
			set_jumps()
			move_vector.y = 0
		if $Body.is_on_ceiling():
			move_vector.y = 0
		move_vector += GRAVITY
		
		# Read directional movement inputs
		if demo:
			pass	# Todo: Demo playeback
		else:
			if Input.is_action_just_pressed("ui_up"):
				if jumps >0:
					move_vector=JUMP
					jumps-=1
				pass
			if Input.is_action_pressed("ui_down"):
				if $Body.is_on_floor():
					Crouch()
				else:
					move_vector+= ACC_FALL
				pass
			move_vector.x = 0 #no compounding horizontal velocity.
			if Input.is_action_pressed("ui_left"):
				if $Body.is_on_floor():
					move_vector-=GROUND_SPEED_BWD
				else:
					move_vector-=AIR_SPEED_BWD
				pass
			if Input.is_action_pressed("ui_right"):
				if $Body.is_on_floor():
					move_vector+=GROUND_SPEED_FWD
				else:
					move_vector+=AIR_SPEED_FWD

			# Read Grapple Inputs
			if Input.is_action_just_pressed("grapple") and !grappling:
				grappling = true
				grappled = false
				$Grapple.position = $Body.position + GRAPPLE_LAUNCH_OFFSET
				$Grapple.move_and_slide(Vector2(0,0))
		
		# Process grapple logic
		if grappling:
			if Input.is_action_just_released("grapple"):
				reset_grapple()
			if !grappled:
				if $Grapple.is_on_wall():
					grapple_vector = GRAPPLED_VELOCITY
					grappled = true
					#grapple_radius = ($Grapple.position - $Body.position).abs() # hopefully can end up helping with the strange drift at some point.
				else:
					grapple_vector = GRAPPLE_VELOCITY
			else:
				if !$Grapple.is_on_wall():
					reset_grapple()
				grapple_vector = GRAPPLED_VELOCITY
				grapple_offset = $Grapple.position - $Body.position
				if grapple_offset.normalized().dot(move_vector) < 0:
					move_vector -= grapple_offset.normalized()*grapple_offset.normalized().dot(move_vector)
		#$Debug.text = "Grapple Offset = " + str(grapple_offset) + ", Move Vector = " + str(move_vector)
		
		# Apply Velocities
		if move_vector.y>VEL_TERMINAL:
			move_vector.y = VEL_TERMINAL
		elif move_vector.y < -VEL_TERMINAL:
			move_vector.y = -VEL_TERMINAL
		move_vector = $Body.move_and_slide(move_vector,UP)
		$Grapple.move_and_slide(grapple_vector)
		
		# Check if off screen
		if $Body.position.y > SCREEN_BOTTOM:
			if $DeathTimer.is_stopped():
				$DeathTimer.start(CHANCE_TIME)
		else:
			$DeathTimer.stop()
		pass

func Crouch():
	pass
	
func on_death():
	$Body.position = SPAWN_POSITION
	move_vector = SPAWN_VEL
	deaths+=1
	if deaths >= MAX_DEATHS:
		emit_signal("Game_Over")
	set_jumps()
	
func set_jumps():
	jumps = STORED_JUMPS

func display_labels():
	if demo:
		$Deaths.hide()
		$Jumps.hide()
	else:
		$Deaths.text = "Deaths = " + str(deaths)
		$Jumps.text = "Jumps = " + str(jumps)

func reset_grapple():
	grappling = false
	grappled = false
	$Grapple.position = GRAPPLE_STORAGE_POSITION


