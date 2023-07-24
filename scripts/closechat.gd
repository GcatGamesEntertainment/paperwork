extends TextureRect

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and get_global_rect().has_point(get_global_mouse_position()) and !get_parent().get_parent().get_parent().get_node("ContactShareGUI").is_enabled: get_parent().get_parent().close_chat()
