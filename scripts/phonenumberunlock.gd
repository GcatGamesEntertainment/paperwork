extends RichTextLabel

export var contact : String

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and get_global_rect().has_point(get_global_mouse_position()): 
		var root = get_tree().root.get_node("Game")
		root.get_node("Phone/MouseArea/ContactGUI").add_contact(contact)
		if root.dialog_funcs.keys().has(contact): root.call(root.dialog_funcs[contact])
