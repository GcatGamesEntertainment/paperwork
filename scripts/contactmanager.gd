extends Control

var contacts_closed
var contact_object = preload("res://objects/Contact.tscn")
var sfx = preload("res://sounds/ping.wav")
var rsfx = preload("res://sounds/research.wav")
var added_contacts = {}
var tween : Tween
var manager
var response_gotten = ""

export var fastmode = false

func _ready():
	manager = get_tree().root.get_node("Game")

	tween = Tween.new()
	add_child(tween)

func open_chat(name:String):
	_close_contacts()
	get_parent().get_parent().create_chat(name)
func set_opened():
	if !contacts_closed: return
	contacts_closed = false

func update_contacts():
	for i in manager.dialogs.keys(): 
		if !(added_contacts.keys().has(i.to_lower())): _add_contact(i)
func add_contact(name:String):
	if manager.dialogs.keys().has(name): return
	manager.dialogs[name] = []
	update_contacts()
	_play_research_sound()
func send_messages(name:String, msgs:Array):
	for i in msgs:
		_add_message(name, i)
		if !fastmode: yield(get_tree().create_timer(max(i.length()/20, 1)), "timeout")
		else: yield(get_tree(), "idle_frame")

func add_response(name:String, response:String):
	manager.responses[name] = response

	if contacts_closed and get_parent().get_node("ChatGUI").get_name()==name: get_parent().get_node("ChatGUI").set_response(name, response)

	while response_gotten!=name: yield(get_tree(), "idle_frame")

	response_gotten = ""
	manager.responses.erase(name)

func respond(name:String): response_gotten = name
func _add_message(name:String, msg:String):
	manager.dialogs[name].append(msg)
	if contacts_closed and get_parent().get_node("ChatGUI").get_name()==name: get_parent().get_node("ChatGUI").add_message(msg)
	_update_last_message(name, added_contacts[name.to_lower()].get_node("LastMessage"))

	if !get_parent().is_out:
		var ping = get_parent().get_parent().get_node("Ping")

		if !ping.visible: _play_ping_sound()
		ping.visible = true
func _add_contact(name:String):
	var new_contact = contact_object.instance()
	var contact_list = get_node("Scroll/ContactList")

	new_contact.contact_name = name
	_update_last_message(name, new_contact.get_node("LastMessage"))

	var new_y = new_contact.rect_position.y+new_contact.rect_size.y*len(added_contacts.keys())
	if new_y>contact_list.rect_min_size.y: contact_list.rect_min_size.y += (new_y-contact_list.rect_min_size.y)+(new_contact.rect_size.y-1)
	new_contact.rect_position.y = new_y

	added_contacts[name.to_lower()] = new_contact
	contact_list.add_child(new_contact)
func _update_last_message(name: String, node: Label):
	node.text = ((manager.dialogs[name][-1].substr(0, 18)+"..." if manager.dialogs[name][-1].length()>18 else manager.dialogs[name][-1]) if len(manager.dialogs[name])>0 else "").trim_prefix("$")
# warnings-disable
func _close_contacts():
	if contacts_closed: return

	tween.interpolate_property(self, "rect_position", rect_position, Vector2(rect_position.x-rect_size.x, rect_position.y), .1, Tween.TRANS_LINEAR)
	tween.start()

	contacts_closed = true
func _play_ping_sound():
	var player = AudioStreamPlayer.new()
	player.stream = sfx
	add_child(player)
	player.play()
func _play_research_sound():
	var player = AudioStreamPlayer.new()
	player.stream = rsfx
	add_child(player)
	player.play()

	
