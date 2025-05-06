extends Control

@onready var RScore = $VBoxContainer/HBoxContainer/ReactionScore
@onready var MemScore = $VBoxContainer/HBoxContainer/MemoryScore
@onready var FAScore = $VBoxContainer/HBoxContainer2/FandAScore
@onready var DeScore = $VBoxContainer/HBoxContainer2/DecisionScore

func set_score(RS : float, MS : float, FAS : float, DS : float):
	RScore.text = RS
	MemScore.text = MS
	FAScore.text = FAS
	DeScore.text = DS
	
