extends ScrollContainer

func _ready(): scroll_to_bottom()
func scroll_to_bottom():
	var scrollbar = get_v_scrollbar()
	yield(get_tree(), "idle_frame")
	scrollbar.value = scrollbar.max_value
