extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_on_Continue_Button_pressed()
	pass


func _on_Continue_Button_pressed():
	queue_free()
	pass # Replace with function body.


func _on_Quit_Button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Restart_Button_pressed():
	get_tree().change_scene("res://Game Scene.tscn")
	pass # Replace with function body.


func _on_Quit_to_Title_Button_pressed():
	get_tree().change_scene("res://Title Screen.tscn")
	pass # Replace with function body.
