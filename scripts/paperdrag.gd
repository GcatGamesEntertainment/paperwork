extends ColorRect

var canBeHeld = false
var hovered = false
var held = false
var shadow : ColorRect 
var sfx = preload("res://sounds/drop.wav")

# warnings-disable
func _ready():
	connect("mouse_entered", self, "_on_hover")
	connect("mouse_exited", self, "_on_hover_left")
func _input(event: InputEvent):
	if !canBeHeld: return

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed and hovered: 
			_create_shadow()
			_move_paper()
			held = true
		elif held:
			if shadow: shadow.queue_free()
			if get_parent().rect_global_position.y+get_parent().rect_size.y>rect_global_position.y+rect_size.y+25: rect_global_position.y += 25
			_drop_sound()
			held = false
	
	if event is InputEventMouseMotion and held: _move_paper()
func _on_hover(): hovered = true
func _on_hover_left(): hovered = false

func enable_holding(): canBeHeld = true
	
func _create_shadow():
	shadow = ColorRect.new()
	shadow.color = Color(0, 0, 0, .5)
	shadow.rect_position.y = 25
	shadow.rect_size = rect_size
	shadow.show_behind_parent = true
	add_child(shadow)
func _move_paper():
	get_parent().move_child(self, get_parent().get_child_count())

	var mouse_pos = get_global_mouse_position()
	var size = rect_size
	var parent_pos = get_parent().rect_global_position
	var parent_size = get_parent().rect_size
	var parent_width = parent_pos.x+parent_size.x
	var parent_height = parent_pos.y+parent_size.y

	if parent_width>rect_global_position.x+size.x or parent_width>mouse_pos.x+size.x: rect_global_position.x = max(mouse_pos.x-(size.x/2), parent_pos.x)
	if parent_height>rect_global_position.y+size.y or parent_height>mouse_pos.y+size.y: rect_global_position.y = max(mouse_pos.y, parent_pos.y)-25
func _drop_sound():
	var player = AudioStreamPlayer.new()
	player.stream = sfx
	add_child(player)
	player.play()
