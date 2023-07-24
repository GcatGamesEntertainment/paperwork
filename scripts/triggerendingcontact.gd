extends Control

func _input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and get_global_rect().has_point(get_global_mouse_position()): Ending.trigger_ending(get_node("Name").text, get_tree().root.get_node("Game").knowledge)
