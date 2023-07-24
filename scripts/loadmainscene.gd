extends Button

func _on_Press():
	Ending.main_scene()

func _on_Quit_pressed():
	get_tree().quit()
