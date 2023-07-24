extends Control

export var contact_name : String
signal chatopen

func _ready():
	get_node("Name").text = contact_name

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and get_global_rect().has_point(get_global_mouse_position()): 
		get_parent().get_parent().get_parent().open_chat(contact_name)
		emit_signal("chatopen")
