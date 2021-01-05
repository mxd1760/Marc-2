extends MarginContainer


var GAME_SCENE = "res://Scenes//Game Scene.tscn"
var MAIN_MENU = "res://Scenes//Title Screen.tscn"

func _ready():
	pass # Replace with function body.

func _on_Play_Button_pressed():
	get_tree().change_scene(GAME_SCENE)
	pass # Replace with function body.

func _on_Back_Button_pressed():
	get_tree().change_scene(MAIN_MENU)
	pass # Replace with function body.
