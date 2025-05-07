extends Control

@onready var RScore = $VBoxContainer/HBoxContainer/ReactionScore
@onready var MemScore = $VBoxContainer/HBoxContainer/MemoryScore
@onready var FAScore = $VBoxContainer/HBoxContainer2/FandAScore
@onready var DeScore = $VBoxContainer/HBoxContainer2/DecisionScore

var rs
var ms
var fas
var ds

func set_score(RS : float, MS : float, FAS : float, DS : float):
	RScore.text = "%.02f" % RS
	MemScore.text = "%d" % MS
	FAScore.text = "%d" % FAS
	DeScore.text = "%d" % DS
	rs = RS
	ms = MS
	fas = FAS
	ds = DS
