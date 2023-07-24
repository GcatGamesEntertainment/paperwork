extends Control

func _ready():
	var result
	var desciption

	if !Ending._suspect: 
		result = "Dead"
		desciption = "Somebody broke into the house you were working in and killed you. You have a suspicion that they were related to the case. Ah well, in another life."
	elif Ending._suspect=="adam christianson" and Ending._knowledge.has("adamguilty"): 
		result = "Alive"
		desciption = "You correctly identified the murderer. After further investigation, police found out that Adam had symptoms of dissociative identity disorder, making him more agressive during nighttime. One night, he decided to kill his wife. Well done."
	else: 
		result = "Fired"
		if Ending._suspect=="ben willson" and Ending._knowledge.has("benguilty"):
			desciption = "You incorrectly pointed to Ben. After further investigation, police found out that he had nothing to do with Sara and was just delivering the package to her. That night was the first time he had visited her house. You were fired from the company." 
		elif Ending._suspect=="lara thompson" and Ending._knowledge.has("laraguilty"):
			desciption = "You incorrectly pointed to Lara. After further investigation, police found out that she was just visiting her house that day. They didn't even had an argument and she did not return to the house. You were fired from the company." 
		else:
			desciption = "You incorrectly pointed to someone that had nothing to do with the case. Your boss was disappointed. You were fired from the company." 

	get_node("BG").texture = load("res://assets/ending/"+result.to_lower()+".png")
	get_node("Verdict").text = "Verdict: "+result
	get_node("Description").text = desciption

func _retry():
	Ending.main_scene()
