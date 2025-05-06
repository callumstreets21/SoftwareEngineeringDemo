extends Node2D

func _ready():
	

	Database.load_database()



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Displays/DisplayBase/DisplayBase.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action("InjectFakeData"):
		Database.add_entry(1, 2, 4, 5)
		Database.add_entry(1, 2, 4, 5)
		Database.add_entry(1, 2, 4, 5)
		Database.add_entry(1, 2, 4, 5)
		Database.add_entry(1, 2, 4, 5)
		
				# Get last 5 entries
		var recent = Database.get_latest_entries(5)
		for entry in recent:
			print(entry)
