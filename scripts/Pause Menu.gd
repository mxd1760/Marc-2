extends MarginContainer


var CurrentSong


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
	get_tree().call_group("Loader","Load_Game",CurrentSong)
	pass # Replace with function body.


func _on_Quit_to_Title_Button_pressed():
	get_tree().call_group("Loader","Load_Main_Menu")
	pass # Replace with function body.
