extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var GAME_OVER_MENU
export (PackedScene) var PAUSE_MENU
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
		if not (has_node("Pause Menu") or has_node("Game Over Menu")):
			paused = false
			if Input.is_action_just_pressed("pause"):
				pause_game()
		$Player.phys_paused = paused
		$Platforms.phys_paused = paused



func _on_Player_Game_Over():
	if !demo:
		add_child(GAME_OVER_MENU.instance())
		paused = true
	
func pause_game():
	if !demo:
		add_child(PAUSE_MENU.instance())
		paused = true
		
		
		
