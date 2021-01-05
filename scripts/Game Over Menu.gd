extends MarginContainer


var GAME_SCENE = "res://Scenes//Game Scene.tscn"
var MAIN_MENU = "res://Scenes//Title Screen.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_Button_pressed():
	get_tree().change_scene(GAME_SCENE)
	pass # Replace with function body.


func _on_Back_Button_pressed():
	get_tree().change_scene(MAIN_MENU)
	pass # Replace with function body.


func _on_Quit_Button_pressed():
	get_tree().quit()
	pass # Replace with function body.
