extends Node

var _suspect
var _knowledge

# warnings-disable
func trigger_ending(suspect:String, knowledge:Array):
	_suspect = suspect
	_knowledge = knowledge

	get_tree().change_scene("res://scenes/ending.tscn")
func main_menu():
	get_tree().change_scene("res://scenes/mainmenu.tscn")
func main_scene():
	get_tree().change_scene("res://scenes/main.tscn")