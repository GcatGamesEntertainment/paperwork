extends Control

var tween : Tween
var contactlist : Control
var smallcontact = preload("res://objects/ContactSmall.tscn")
export var is_enabled = false

func _ready():
	tween = Tween.new()
	add_child(tween)
	
	contactlist = get_node("Scroll/ContactList")
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and get_node("BackArrow").get_global_rect().has_point(get_global_mouse_position()): _disable()

# warnings-disable
func enable():
	tween.interpolate_property(self, "rect_position:y", rect_position.y, rect_position.y-rect_size.y, .2, Tween.TRANS_LINEAR)
	tween.start()

	var contact_count = 0
	for c in get_parent().get_node("ContactGUI").added_contacts.keys():
		var new_contact = smallcontact.instance()
		var new_y = new_contact.rect_size.y*contact_count

		if new_y>contactlist.rect_min_size.y: contactlist.rect_min_size.y += (new_y-contactlist.rect_min_size.y)+(new_contact.rect_size.y*2-1)

		new_contact.get_child(0).text = c
		new_contact.rect_position.y = new_y
		contactlist.add_child(new_contact)
		
		contact_count += 1

	is_enabled = true
# warnings-disable
func _disable():
	tween.interpolate_property(self, "rect_position:y", rect_position.y, rect_position.y+rect_size.y, .2, Tween.TRANS_LINEAR)
	tween.start()
	yield(tween, "tween_all_completed")

	for c in contactlist.get_children(): c.queue_free()

	get_tree().root.get_node("Game").share_contact_response()
	is_enabled = false

