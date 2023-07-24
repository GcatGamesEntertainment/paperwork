extends Control

var chat_gui = preload("res://objects/ChatGUI.tscn")
var manager

func _ready():
	manager = get_tree().root.get_node("Game")

func create_chat(name:String):
	var instance = chat_gui.instance()

	instance.update_name(name)
	for msg in manager.dialogs[name]: instance.add_message(msg)
	if manager.responses.has(name): instance.set_response(name, manager.responses[name])
	instance.open_chat()

	get_node("MouseArea").add_child_below_node(get_node("MouseArea/ContactGUI"), instance)
