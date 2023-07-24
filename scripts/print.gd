extends TextureRect

var tween : Tween
var sfx = preload("res://sounds/print.wav")

func _ready():
	tween = Tween.new()
	add_child(tween)

# warnings-disable
func print_paper(paper: PackedScene):
	var new_paper : Control = paper.instance()
	var starter_pos = Vector2((rect_size.x/2)-(new_paper.rect_size.x/2), -new_paper.rect_size.y-rect_size.y)

	new_paper.rect_global_position = starter_pos
	get_parent().get_node("Table").add_child(new_paper)

	tween.interpolate_property(new_paper, "rect_position", starter_pos, Vector2(starter_pos.x, 0), .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.connect("tween_all_completed", new_paper, "enable_holding")
	tween.start()

	_print_sound()
func _print_sound():
	var player = AudioStreamPlayer.new()
	player.stream = sfx
	add_child(player)
	player.play()
	
