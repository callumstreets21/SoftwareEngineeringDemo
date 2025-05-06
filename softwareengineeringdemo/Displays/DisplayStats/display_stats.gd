extends Control

@onready var stats1 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat
@onready var stats2 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat2
@onready var stats3 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat3
@onready var stats4 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat4
@onready var stats5 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat5
@onready var statsAll = [stats1, stats2, stats3, stats4, stats5]

@onready var upButton = $HBoxContainer/TextureRect/VBoxContainer/HBoxContainer/Button
@onready var downButton = $HBoxContainer/TextureRect/VBoxContainer/HBoxContainer/Button2

@onready var mem = $HBoxContainer/TextureRect/VBoxContainer/Mem
@onready var reac = $HBoxContainer/TextureRect/VBoxContainer/Reac
@onready var fanda = $HBoxContainer/TextureRect/VBoxContainer/FandA
@onready var dec = $HBoxContainer/TextureRect/VBoxContainer/Dec

var buttonPressed = false

var listPos = 0

func _process(delta: float) -> void:
	var starting = listPos
	if upButton.is_pressed() && !buttonPressed:
		listPos -= 1
		buttonPressed = true
	elif downButton.is_pressed()  && !buttonPressed:
		listPos += 1
		buttonPressed = true
	
	if !downButton.is_pressed() && !upButton.is_pressed():
		buttonPressed = false
	
	if starting != listPos:
		if listPos > 4:
			listPos = 0
		elif listPos < 0:
			listPos = 4
		print("rs: %f" %statsAll[listPos].rs)
		reac.text = feedbackgen.FeedbackReaction(statsAll[listPos].rs)
		fanda.text = feedbackgen.FeedbackFocus(statsAll[listPos].fas)
		refresh()

func _ready() -> void:
	refresh()
	reac.text = feedbackgen.FeedbackReaction(statsAll[listPos].rs)
	fanda.text = feedbackgen.FeedbackFocus(statsAll[listPos].fas)
			

func refresh():
	Database.load_database()
	var entries = Database.get_latest_entries(5)
	for entry in entries:
		print(entry)
	if entries.size() > 0:
		var counter = 0
		for entry in entries:
			print("loaded rs: %f" %entry["Reaction"])
			statsAll[counter].set_score(entry["Reaction"], entry["Memory"], entry["FandA"], entry["Decision"])
			counter += 1
	else:
		for stats in statsAll:
			stats.set_score(-1,-1,-1,-1)
			
