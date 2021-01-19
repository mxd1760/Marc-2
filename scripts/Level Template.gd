extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var GAME_OVER_MENU
export (PackedScene) var PAUSE_MENU
const DEMO_PARENT =  "Title Screen"
const PAUSE_MUFFLE = 10 #db so is a relative adjustment
const UNPAUSE_TIME = 3
const COUNTDOWN_WAIT_TIME = 0.6

var paused = false
var demo = false
var paused_playback_position
var countdown

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == DEMO_PARENT:
		demo = true
	else:
		demo = false
	set_pause(false)
	$Player.demo = demo
	$Countdown.text = ""
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !demo:
		if not (has_node("Pause Menu") or has_node("Game Over Menu")):
			set_pause(false)
			if Input.is_action_just_pressed("pause"):
				pause_game()
		$Player.phys_paused = paused
		$Plats.paused = paused



func _on_Player_Game_Over():
	if !demo:
		var menu = GAME_OVER_MENU.instance()
		menu.CurrentSong = $"Level Music".stream
		add_child(menu)
		set_pause(true)
	
func pause_game():
	if !demo:
		var menu = PAUSE_MENU.instance()
		menu.CurrentSong = $"Level Music".stream
		add_child(menu)
		set_pause(true)
		
func set_song(song):
	$"Level Music".stop()
	$"Level Music".set_stream(song)
	$"Level Music".play()
	
func set_pause(value):
	if value == true:
		paused = true
		$Unpause.stop()
		paused_playback_position = $"Level Music".get_playback_position()
		$"Level Music".volume_db -= PAUSE_MUFFLE
	elif paused == true && $Unpause.is_stopped():
		run_unpause_countdown(UNPAUSE_TIME)
		$"Level Music".volume_db += PAUSE_MUFFLE
		$"Level Music".play(paused_playback_position-(UNPAUSE_TIME*COUNTDOWN_WAIT_TIME))
		

func run_unpause_countdown(count):
	#this should do something graphical to show the game is about to resume
	countdown = count - 1
	$Unpause.start(COUNTDOWN_WAIT_TIME)
	if count == 0:
		$Countdown.text = "GO!"
	else:
		$Countdown.text = str(count)

func _on_Unpause_timeout():
	if countdown > 0:
		run_unpause_countdown(countdown)
	elif countdown <0:
		$Countdown.text = ""
	else:
		run_unpause_countdown(countdown)
		paused = false
	pass # Replace with function body.

