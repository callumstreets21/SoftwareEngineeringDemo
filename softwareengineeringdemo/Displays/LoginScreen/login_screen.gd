extends Node2D


@onready var ID = $CanvasLayer/Panel/VBoxContainer/LineEdit
@onready var Pass = $CanvasLayer/Panel/VBoxContainer/LineEdit2
@onready var loginFail = $CanvasLayer/Panel/VBoxContainer/loginFail


func _ready():
	

	Database.load_database()



func _on_button_pressed() -> void:
	if ID.text == "admin" && Pass.text == "pass":
		get_tree().change_scene_to_file("res://Displays/DisplayBase/DisplayBase.tscn")
	else:
		loginFail.text = "Login failed, invalid ID or Password"
		Pass.text = ""
		await get_tree().create_timer(5).timeout
		loginFail.text = ""
	

func _input(event: InputEvent) -> void:
	if event.is_action("InjectFakeData"):
		Database.add_entry(37, 0.19, 8, 10)
		Database.add_entry(29, 0.5, 6, 13)
		Database.add_entry(49, 0.7, 4, 15)
		Database.add_entry(62, 1.2, 2, 18)
		Database.add_entry(80, 6, 1, 23)
		
				# Get last 5 entries
		var recent = Database.get_latest_entries(5)
		for entry in recent:
			print(entry)
