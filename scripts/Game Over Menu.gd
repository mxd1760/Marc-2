extends MarginContainer

var CurrentSong


func _on_Play_Button_pressed():
	get_tree().call_group("Loader","Load_Game",CurrentSong)
	pass # Replace with function body.


func _on_Back_Button_pressed():
	get_tree().call_group("Loader","Load_Main_Menu")
	pass # Replace with function body.


func _on_Quit_Button_pressed():
	get_tree().quit()
	pass # Replace with function body.
