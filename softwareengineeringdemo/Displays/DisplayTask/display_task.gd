extends Control


@onready var FT = $HBoxContainer/TextureRect/FocusScene
@onready var RT = $HBoxContainer/TextureRect/ReactionTime
@onready var currentTaskIterator = 0

var FTScore = 0
var RTScore = 0
var DTScore = 0
var MTScore = 0


func _ready() -> void:
	FT.visible = false
	RT.visible = false


func _on_button_pressed() -> void:
	run_tasks()

func _process(delta: float) -> void:
	if currentTaskIterator == 1 && FT.gameended:
		FTScore = FT.round_count
		FT.visible = false
		RT.visible = true
		currentTaskIterator = 2
		RT.start_game()
	if currentTaskIterator == 2 && RT.gameended:
		RTScore = RT.score
		RT.visible = false
		currentTaskIterator = 3
		

func run_tasks() -> void:
	if currentTaskIterator == 0:
		print("starting first task")
		currentTaskIterator = 1
		FT.visible = true
		FT.start_game()
		
		
