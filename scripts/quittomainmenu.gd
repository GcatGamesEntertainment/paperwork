extends TextureRect

func _input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and get_global_rect().has_point(get_global_mouse_position()): Ending.main_menu()
