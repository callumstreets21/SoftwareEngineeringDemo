extends Control

var colors = ["Red", "Green", "Blue", "Yellow"]
var sequence = []
var player_index = 0
var playing_sequence = false
var round_count = 0
var max_rounds = 10
var total_tries = 10
var tries_left = total_tries


@onready var label = $PanelContainer/VBoxContainer/HBoxContainer/Label
@onready var panel = $PanelContainer
@onready var buttons = {
	"Red": $PanelContainer/VBoxContainer/RedButton,
	"Green": $PanelContainer/VBoxContainer/GreenButton,
	"Blue": $PanelContainer/VBoxContainer/HBoxContainer/BlueButton,
	"Yellow": $PanelContainer/VBoxContainer/HBoxContainer/YellowButton,
}

var highlight_colors = {
	"Red": Color(1.5, 0.6, 0.6),
	"Green": Color(0.6, 1.5, 0.6),
	"Blue": Color(0.6, 0.6, 1.5),
	"Yellow": Color(1.5, 1.5, 0.6)
}

var normal_colors = {
	"Red": Color(0.8, 0.0, 1.0),
	"Green": Color(1.0, 0.8, 0.0),
	"Blue": Color(0.0, 1.0, 0.8),
	"Yellow": Color(1.8, 0.8, 1.0)
}


func _ready():
	start_game()
	for color in colors:
		buttons[color].pressed.connect(func(): _on_button_pressed(color))
	#adjust_button_positions()

func adjust_button_positions():
	var panel_size = panel.get_rect().size
	var panel_position = panel.global_position
	var center_x = panel_position.x + panel_size.x * 0.5
	var center_y = panel_position.y + panel_size.y * 0.5
	var spacing_x = panel_size.x * 0.2
	var spacing_y = panel_size.y * 0.2  

	var positions = {
		"Red": Vector2(center_x, center_y - spacing_y),
		"Green": Vector2(center_x, center_y + spacing_y),
		"Blue": Vector2(center_x - spacing_x, center_y),
		"Yellow": Vector2(center_x + spacing_x, center_y)
	}

	for color in colors:
		var button = buttons[color]
		var base_size = button.get_rect().size
		var scale_factor = min(panel_size.x * 0.2 / base_size.x, panel_size.y * 0.2 / base_size.y)
		button.scale = Vector2(scale_factor, scale_factor)

		var new_size = base_size * scale_factor

		#adjust position to counter top-left scaling effect
		button.position = positions[color] - new_size * 0.5


func start_game():
	sequence.clear()
	round_count = 0 
	tries_left = 10
	preset_button_colors()
	print(str(panel.size.x))
	
func end_game():
	print(str(tries_left/total_tries))

func preset_button_colors():
	for color in colors:
		buttons[color].modulate = normal_colors[color]
	add_color_to_sequence()

func add_color_to_sequence():
	player_index = 0
	var rng = RandomNumberGenerator.new()
	var new_color = colors[rng.randi_range(0, colors.size() - 1)]
	sequence.append(new_color)
	label.text = "Watch the sequence"
	playing_sequence = true
	show_sequence(0)

func show_sequence(index):
	if index >= sequence.size():
		playing_sequence = false
		label.text = "Your turn"
		return
	var color = sequence[index]
	highlight_button(color)
	await get_tree().create_timer(0.6).timeout
	unhighlight_button(color)
	await get_tree().create_timer(0.2).timeout
	show_sequence(index + 1)

func highlight_button(color):
	buttons[color].modulate = highlight_colors[color]

func unhighlight_button(color):
	buttons[color].modulate = normal_colors[color]
	
func show_press_feedback(color):
	buttons[color].modulate = highlight_colors[color]
	await get_tree().create_timer(0.2).timeout
	buttons[color].modulate = normal_colors[color]

func _on_button_pressed(color) -> void:
	if playing_sequence:
		return

	await show_press_feedback(color)

	if color == sequence[player_index]:
		player_index += 1
		if player_index >= sequence.size():
			round_count += 1 #on success

			if round_count >= max_rounds:
				label.text = "You won all 10 rounds!"
				await get_tree().create_timer(2).timeout
				end_game()
				return

			label.text = "Correct! Round %d of %d" % [round_count, max_rounds]
			await get_tree().create_timer(1).timeout
			add_color_to_sequence()
	else:
		tries_left -= 1

		if tries_left <= 0:
			label.text = "No tries left! Game over."
			await get_tree().create_timer(2).timeout
			end_game()
		else:
			label.text = "Wrong! Tries left: %d" % tries_left
			await get_tree().create_timer(1.5).timeout
			player_index = 0
			label.text = "Watch again"
			playing_sequence = true
			await get_tree().create_timer(1).timeout
			show_sequence(0)
