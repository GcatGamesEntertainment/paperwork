extends Control

# I am sorry this code is bad
# It's shit

var contacts : Control
var printer : Control
var tooltip : Control
export var dialogs = {
	"Boss": []
}
export var responses = {}
export var knowledge = []
export var dialog_funcs = {
	"Adam Christianson": "_adam",
	"Lara Thompson": "_lara",
	"Daniel Thompson": "_daniel",
	"James Wright": "_james",
	"Ben Willson": "_ben",
	"Everith-Inal Rightman": "_rightman",
	"Max Evans": "_max"
}

func _ready():
	contacts = get_node("Phone/MouseArea/ContactGUI")
	printer = get_node("PrinterBottom")
	tooltip = get_node("Tooltip")

	contacts.update_contacts()

	if !contacts.fastmode: yield(get_tree().create_timer(3), "timeout")
	yield(contacts.send_messages("Boss", [
		"Ey",
		"Did you get to the place yet?"
	]), "completed")
	yield(contacts.add_response("Boss", "Yes"), "completed")
	yield(contacts.send_messages("Boss", [
		"$I'm here",
		"Great!",
		"So, to lay down the general picture:",
		"We were hired by Adam Christianson, the husband of Sara Christianson",
		"Sara was murdered last year. The police did a horrible job of investigating it.",
		"They didn't arrest anybody, hell they only had one suspect.",
		"That's exactly why adam called us",
		"He didn't pay much, you have only 1 day to figure out who did it",
		"Luckly the case isn't that complicated, or at least I hope so.",
		"I'm gonna fax you some documents, wait."
	]), "completed")
	yield(get_tree(), "idle_frame")
	printer.print_paper(load("res://objects/paper/AutopsyReport.tscn"))
	yield(get_tree().create_timer(1.5), "timeout")
	printer.print_paper(load("res://objects/paper/PoliceReport.tscn"))
	yield(contacts.send_messages("Boss", [
		"Here's the autopsy report and the police report",
		"When you're done investigating, send me the phone number of your main suspect.",
		"Then get out, everything else I will handle myself",
		"Good luck and see you soon."
	]), "completed")
	tooltip.show_tooltip()
	share_contact_response()

func share_contact_response():
	yield(contacts.add_response("Boss", "Share Contact"), "completed")
	get_node("Phone/MouseArea/ContactShareGUI").enable()

func _adam():
	yield(contacts.add_response("Adam Christianson", "Hello"), "completed")
	yield(contacts.send_messages("Adam Christianson", [
		"$Hello",
		"Oh hey! You must be the private detective they've sent. Nice to meet you!",
		"Glad someone will actually take a look at this case again...",
		"Police was so unhelpful during the investigation",
		"They arrested some random kid that was just delivering packages!",
		"Hope you will actually solve this.",
		"If you need anything, don't be afraid to ask!"
	]), "completed")
	while !knowledge.has("laratalk"): yield(get_tree(), "idle_frame")
	yield(contacts.add_response("Adam Christianson", "Ask about Lara"), "completed")
	yield(contacts.send_messages("Adam Christianson", [
		"$Sara and her sister Lara didn't have the best relationship from what I can tell",
		"$Do you know anything about this?",
		"They never got along, they are just completely different kinds of people.",
		"Her sister would always come into our house asking for money",
		"She wasn't the most successful when it came to job offers",
		"Lara was always jealous of Sara's success",
		"Actually, let me check, maybe she was at our house that day",
		"I think I have a security system log"
	]), "completed")
	yield(get_tree().create_timer(5), "timeout")
	yield(contacts.send_messages("Adam Christianson", [
		"Oh god",
		"The last thing before the system got turned off by the murderer, it shows that Sara let Lara in",
		"I'm not occusing her but...",
		"You know what, instead of making assumptions, I'm gonna fax you the log."
	]), "completed")
	yield(get_tree().create_timer(1.5), "timeout")
	printer.print_paper(load("res://objects/paper/SecurityLog1.tscn"))
	yield(get_tree().create_timer(.5), "timeout")
	printer.print_paper(load("res://objects/paper/SecurityLog2.tscn"))
	yield(get_tree().create_timer(1), "timeout")
	yield(contacts.send_messages("Adam Christianson", [
		"There you go",
		"If it was her...",
		"I'm just not gonna think about it"
	]), "completed")
	while !knowledge.has("doctor"): yield(get_tree(), "idle_frame")
	yield(contacts.add_response("Adam Christianson", "Ask about Doctor"), "completed")
	yield(contacts.send_messages("Adam Christianson", [
		"$The log shows a \"doctor\" entering the house",
		"$Do you know who this is?",
		"Oh doctor?",
		"Probably it's out family doctor entering",
		"His name is Max Evans",
		"I'm gonna send you his phone number"
	]), "completed")
	contacts.add_contact("Max Evans")
	_max()
	yield(contacts.send_messages("Adam Christianson", [
		"Sara wasn't feeling well that day",
		"She took a day off of work",
		"Probably called him to help"
	]), "completed")
func _lara():
	yield(contacts.add_response("Lara Thompson", "Introduce yourself"), "completed")
	yield(contacts.send_messages("Lara Thompson", [
		"$Hello, I'm a private detective investigating the death of your sister, Sara Christianson.",
		"$Did she act wierd the last few days she was alive?",
		"$I am sorry if this is a hard topic to bring up",
		"Hi",
		"Yeah, she did act wierd",
		"As she always does",
		"She was the most selfish, most evil person I know",
		"One time I messaged her at my lowest point in life, I had close to no money",
		"I really needed help and I needed it quick.",
		"And guess what? She told me to screw off!",
		"She had some \"important competition\" and \"couldn't come home\"",
		"I survived, but I might've not",
		"But hey, I guess she now has a trophy in her house of something.",
		"Screw her",
		"..."
	]), "completed")
	yield(get_tree().create_timer(5), "timeout")
	yield(contacts.send_messages("Lara Thompson", [
		"I am genuinely for her death",
		"but I can't help you",
		"Sorry"
	]), "completed")
	knowledge.append("laratalk")
func _daniel():
	yield(contacts.add_response("Daniel Thompson", "Introduce yourself"), "completed")
	yield(contacts.send_messages("Daniel Thompson", [
		"$Hello, I'm a private detective investigating the death of your sister, Sara Christianson.",
		"$Did she act wierd the last few days she was alive?",
		"$I am sorry if this is a hard topic to bring up",
		"Hello, sorry I can't really comment anything, we didn't really keep contact after she married Adam.",
		"By the way, do you play DigArts?",
		"I love DigArts, especially modded DigArts.",
		"$...",
		"Oh I also make modcollections for DigArts, wanna see?",
		"Wait, no need to respond, I'm gonna send you and advert I made",
		"Checkout the website on the card, I'm so proud of it!!"
	]), "completed")
	yield(get_tree().create_timer(1.5), "timeout")
	printer.print_paper(load("res://objects/paper/NewishModcollections.tscn"))
func _james():
	yield(contacts.add_response("James Wright", "Introduce yourself"), "completed")
	yield(contacts.send_messages("James Wright", [
		"$Hello, I'm a private detective investigating the death of Sara Christianson.",
		"$From what I can tell, you are the pathologist that wrote the autopsy report",
		"$Is there anything else that you didn't include in the report?",
		"Hi, nice to meet you",
		"Not really",
		"The case was really uninteresting and mundane"
	]), "completed")
	yield(get_tree().create_timer(2.5), "timeout")
	yield(contacts.send_messages("James Wright", [
		"Actually, now that I think about it",
		"There was one detail that was interesting",
		"There were no signes of violence",
		"So Sara probably knew the murderer.",
		"Other than that, I don't think there's anything else important"
	]), "completed")
func _ben():
	yield(contacts.add_response("Ben Willson", "Introduce yourself"), "completed")
	yield(contacts.send_messages("Ben Willson", [
		"$Hello, I'm a private detective investigating the death of Sara Christianson.",
		"$According to the police report, you were the main suspect.",
		"Yes, I was",
		"I will not comment further, speak to my lawyer instead",
		"I will fax you his business card"
	]), "completed")
	yield(get_tree().create_timer(1.5), "timeout")
	printer.print_paper(load("res://objects/paper/RightmanCard.tscn"))
func _rightman():
	yield(contacts.add_response("Everith-Inal Rightman", "Introduce yourself"), "completed")
	yield(contacts.send_messages("Everith-Inal Rightman", [
		"$Hello, I'm a private detective investigating the death of Sara Christianson",
		"$Ben Willson gave me your number.",
		"$Does your client have anything to do with the case?",
		"No, he doesn't",
		"And I will not speak further",
		"Police has his testimony",
		"Refer to that."
	]), "completed")
	knowledge.append("benguilty")
func _max():
	yield(contacts.add_response("Max Evans", "Introduce yourself"), "completed")
	yield(contacts.send_messages("Max Evans", [
		"$Hello, I'm a private detective investigating the death of Sara Christianson",
		"$Adam Christianson gave me your number.",
		"$From what I can tell, you are their family doctor",
		"$Can you please provide me Sara's medical history?",
		"Hello, yes I was but only for the last 2 months of her life",
		"Sure, If I can find it."
	]), "completed")
	yield(get_tree().create_timer(5), "timeout")
	printer.print_paper(load("res://objects/paper/MedicalHistory.tscn"))
	yield(contacts.send_messages("Max Evans", [
		"There you go",
		"Message me if you find anything confusing."
	]), "completed")
	while !knowledge.has("adamdid"): yield(get_tree(), "idle_frame")
	yield(contacts.add_response("Max Evans", "Ask about Adam"), "completed")
	yield(contacts.send_messages("Max Evans", [
		"$In the document, Sara often contacted you during the night period",
		"$Often because of bruise and cuts",
		"$Do you think Adam was beating her?",
		"No clue, during these visits she never told me why she had them",
		"I just assumed she was clusmy, she never complained about her husband",
		"Do you think he could've killed her?"
	]), "completed")
	knowledge.append("adamguilty")
