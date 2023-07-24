extends TextureRect

var s7_theme = preload("res://themes/s7.tres")

func update_message(new_message:String):
	var message : Label = get_child(0)
	if new_message.length()>40: message.theme = s7_theme
	message.text = new_message
