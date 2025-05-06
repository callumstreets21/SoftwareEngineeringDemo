extends Node

@onready var panel = $PanelContainer
@onready var orb = $OrbButton
@onready var label = $PanelContainer/ReactionTimeLabel

var gameended : bool = false

var start_time : float = 0.0
var current_round : int = 0
var rounds : int = 10
var total_reaction_time : float = 0
var score

func _ready():
	orb.hide()

func start_game():
	if current_round != rounds:
		current_round += 1;
		label.text = "Wait for it..."
		orb.hide()
		var delay = randf_range(1.0, 3.0)
		await get_tree().create_timer(delay).timeout
		show_orb()
	else:
		end_game()

func end_game():
	score = total_reaction_time / rounds
	label.text = str(score)
	gameended = true
	

func show_orb():
	var panel_size = panel.get_rect().size
	
	var orb_size = orb.size
	orb.position = Vector2(
		randi() % int(panel_size.x - orb_size.x),
		randi() % int(panel_size.y - orb_size.y)
	)
	orb.show()
	print(str(orb.position))
	start_time = Time.get_ticks_msec() / 1000.0
	label.text = "Click the orb!"
	

func _on_orb_button_pressed() -> void:
	var reaction_time = (Time.get_ticks_msec() / 1000.0) - start_time
	total_reaction_time += reaction_time
	print("Reaction Time: ", reaction_time)
	orb.hide()
	start_game()
