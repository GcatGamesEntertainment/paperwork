extends ColorRect

var sunSpeed = 10*60

func _ready():
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "rect_position", rect_position, Vector2(rect_position.x, -rect_size.y), sunSpeed, Tween.TRANS_LINEAR)
	tween.start()
	
	tween.connect("tween_all_completed", self, "_on_sunset")

func _on_sunset():
	Ending.trigger_ending("", [])
