extends Control

var tween : Tween

# warnings-disable
func show_tooltip():
	tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(self, "modulate:a", 0, 1, 1, Tween.TRANS_LINEAR)
	tween.start()
	tween.connect("tween_all_completed", self, "_hide_tooltip")
# warnings-disable
func _hide_tooltip():
	yield(get_tree().create_timer(5), "timeout")
	tween.interpolate_property(self, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR)
	tween.start()
	tween.disconnect("tween_all_completed", self, "_hide_tooltip")
