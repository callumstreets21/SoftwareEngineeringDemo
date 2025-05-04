extends Node

@onready var orb = $CanvasLayer/OrbButton
@onready var label = $CanvasLayer/ReactionTimeLabel

var start_time : float = 0.0
var current_round : int = 0
var rounds : int = 10
var total_reaction_time : float = 0

func _ready():
	orb.hide()
	start_game()

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
	label.text = str(total_reaction_time / rounds)
	

func show_orb():
	var screen_size = get_viewport().size
	var orb_size = orb.size
	orb.position = Vector2(
		randi() % int(screen_size.x - orb_size.x),
		randi() % int(screen_size.y - orb_size.y)
	)
	orb.show()
	start_time = Time.get_ticks_msec() / 1000.0
	label.text = "Click the orb!"
	

func _on_orb_button_pressed() -> void:
	var reaction_time = (Time.get_ticks_msec() / 1000.0) - start_time
	total_reaction_time += reaction_time
	print("Reaction Time: ", reaction_time)
	orb.hide()
	start_game()
