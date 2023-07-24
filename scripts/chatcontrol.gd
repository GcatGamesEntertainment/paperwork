extends Control

var chat_closed = true
var message_object = preload("res://objects/ChatMessage.tscn")
var self_message_texture = preload("res://assets/chat_bubble_self.png")
var message_count = 0
var tween : Tween

signal response_click

func _init(): 
	tween = Tween.new()
	add_child(tween)
func _input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and get_node("BottomBarBG/Response").get_global_rect().has_point(get_global_mouse_position()): emit_signal("response_click")
func _start_tween():
	tween.start()

func get_name():
	return get_node("TopBarBG/Name").text
func update_name(name:String):
	var name_object : Label = get_node("TopBarBG/Name")
	name_object.text = name
func add_message(text:String):
	var chat_box = get_node("Scroll/ChatBox")
	var message = message_object.instance()
	var new_y = message.rect_position.y+(message_count*(message.rect_size.y+15))

	if new_y>chat_box.rect_min_size.y: chat_box.rect_min_size.y += (new_y-chat_box.rect_min_size.y)+(message.rect_size.y+14)

	message.update_message(text.trim_prefix("$"))
	message.rect_position = Vector2(message.rect_position.x+(80*int(text.begins_with("$"))), new_y)
	if text.begins_with("$"):
		message.texture = self_message_texture
		message.get_child(0).add_color_override("font_color", Color("ffffff"))

	chat_box.add_child(message)
	if is_inside_tree(): get_node("Scroll").scroll_to_bottom()

	message_count += 1
func set_response(name:String, response:String):
	var response_button : Label = get_node("BottomBarBG/Response")
	response_button.text = response
	response_button.mouse_default_cursor_shape = CURSOR_POINTING_HAND

	yield(self, "response_click")

	response_button.text = ""
	response_button.mouse_default_cursor_shape = CURSOR_ARROW

	get_parent().get_node("ContactGUI").respond(name)

# warnings-disable
func close_chat():
	if chat_closed: return
	var contact_gui = get_parent().get_node("ContactGUI")

	tween.interpolate_property(self, "rect_position", rect_position, Vector2(rect_position.x+rect_size.x, rect_position.y), .1, Tween.TRANS_LINEAR)
	tween.interpolate_property(contact_gui, "rect_position", contact_gui.rect_position, Vector2(contact_gui.rect_position.x+contact_gui.rect_size.x, contact_gui.rect_position.y), .1, Tween.TRANS_LINEAR)
	tween.start()

	chat_closed = true
	contact_gui.set_opened()

	tween.connect("tween_all_completed", self, "queue_free")
func open_chat():
	if !chat_closed: return

	tween.interpolate_property(self, "rect_position", rect_position, Vector2(rect_position.x-rect_size.x, rect_position.y), .1, Tween.TRANS_LINEAR)
	tween.connect("tree_entered", self, "_start_tween")

	chat_closed = false
