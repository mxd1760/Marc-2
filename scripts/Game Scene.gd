extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var GAME_OVER_MENU
var PAUSE_MENU
var DEMO_PARENT =  "Title Screen"

var paused = false
var demo = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == DEMO_PARENT:
		demo = true
	else:
		demo = false
	paused = false
	$Player.demo = demo
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !demo:
		if not (is_instance_valid(GAME_OVER_MENU) or is_instance_valid(PAUSE_MENU)):
			paused = false
			if Input.is_action_just_pressed("pause"):
				pause_game()
		$Player.phys_paused = paused
		$Platforms.phys_paused = paused



func _on_Player_Game_Over():
	if !demo:
		GAME_OVER_MENU = preload("res://Game Over Menu.tscn").instance()
		add_child(GAME_OVER_MENU)
		paused = true
	
func pause_game():
	if !demo:
		PAUSE_MENU = preload("res://Pause Menu.tscn").instance()
		add_child(PAUSE_MENU)
		paused = true
		
		
		
