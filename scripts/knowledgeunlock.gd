extends RichTextLabel

export var knowledge_key : String
var sfx = preload("res://sounds/research.wav")

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and get_global_rect().has_point(get_global_mouse_position()): 
		var root = get_tree().root.get_node("Game")
		if !root.knowledge.has(knowledge_key): 
			root.knowledge.append(knowledge_key)
			_play_sound()
func _play_sound():
	var player = AudioStreamPlayer.new()
	player.stream = sfx
	add_child(player)
	player.play()