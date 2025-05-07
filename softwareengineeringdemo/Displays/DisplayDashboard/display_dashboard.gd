extends Control

@onready var stats1 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat
@onready var stats2 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat2
@onready var stats3 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat3
@onready var stats4 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat4
@onready var stats5 = $HBoxContainer/TextureRect3/VBoxContainer/TaskStat5
@onready var statsAll = [stats1, stats2, stats3, stats4, stats5]

@onready var mem = $HBoxContainer/TextureRect/VSplitContainer/VBoxContainer/Mem
@onready var reac = $HBoxContainer/TextureRect/VSplitContainer/VBoxContainer/Reac
@onready var fanda = $HBoxContainer/TextureRect/VSplitContainer/VBoxContainer/FandA
@onready var dec = $HBoxContainer/TextureRect/VSplitContainer/VBoxContainer/Dec


func _ready() -> void:
	refresh()
			
func _process(delta: float) -> void:
	refresh()

func refresh():
	Database.load_database()
	var entries = Database.get_latest_entries(5)
	if entries.size() > 0:
		var counter = 0
		for entry in entries:
			statsAll[counter].set_score( float(entry["Reaction"]), entry["Memory"], entry["FandA"], entry["Decision"])
			counter += 1
	else:
		for stats in statsAll:
			stats.set_score(-1,-1,-1,-1)
	
	reac.text = feedbackgen.FeedbackReaction(statsAll[0].rs)
	fanda.text = feedbackgen.FeedbackFocus(statsAll[0].fas)
	mem.text = feedbackgen.FeedbackMemory(statsAll[0].ms)
	dec.text = feedbackgen.FeedbackDecision(statsAll[0].ds)
