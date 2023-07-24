extends Control

export var is_out = false
var tween

func _ready():
	tween = Tween.new()
	add_child(tween)

func _process(_delta):
	if get_global_rect().has_point(get_global_mouse_position()): _open_Phone()
	else: _close_Phone()

func _change_state():
	if tween.is_active(): return

	is_out = !is_out
	var parent_rect_pos = get_parent().rect_position

	tween.interpolate_property(get_parent(), "rect_position", parent_rect_pos, Vector2(parent_rect_pos.x, parent_rect_pos.y-((rect_size.y-100)*(1 if is_out else -1))), .2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _open_Phone():
	if is_out: return
	get_parent().get_node("Ping").visible = false
	_change_state()

func _close_Phone():
	if !is_out: return
	_change_state()
