extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Play_Button_pressed():
	get_tree().change_scene("res://Game Scene.tscn")
	pass # Replace with function body.

func _on_Back_Button_pressed():
	get_tree().change_scene("res://Title Screen.tscn")
	pass # Replace with function body.
