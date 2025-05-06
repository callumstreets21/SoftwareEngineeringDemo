extends Node


var entries: Array = []  # This holds all entry structs

var file_path = "user://log_database.json"

func is_today(year: int, month: int, day: int) -> bool:
	var now = Time.get_datetime_dict_from_system()
	return now["year"] == year and now["month"] == month and now["day"] == day


# Load the database from file
func load_database() -> void:
	
	if not FileAccess.file_exists(file_path):
		print("no file found")
		entries = []
		return

	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		var json = JSON.parse_string(content)
		if typeof(json) == TYPE_ARRAY:
			entries = json
			print("loaded array, values in array: %d" % entries.size())
		else:
			push_error("JSON is not an array: %s" % file_path)


func add_entry(MemeoryScore : float, ReactionScore : float, FandAScore : float, QuizScore : float) -> void:
	var existing_entries: Array = []
	var now = Time.get_datetime_dict_from_system()
	var new_entry = {
		"Memory" : MemeoryScore,
		"Reaction" : ReactionScore,
		"FandA" : FandAScore,
		"Decision" : QuizScore,
		"day" : now["day"],
		"month" : now["month"],
		"year" : now["year"]
	}
	# Load existing entries (if the file exists and is valid)
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			var parsed = JSON.parse_string(content)
			if typeof(parsed) == TYPE_ARRAY:
				existing_entries = parsed
	# Add the new entry
	existing_entries.append(new_entry)

	# Save updated array back to file
	var json_string = JSON.stringify(existing_entries, "\t")
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
	else:
		push_error("Failed to open file for writing: %s" % file_path)

	# Optional: update in-memory copy if you're tracking entries
	entries = existing_entries

# Get the latest N entries
func get_latest_entries(count: int) -> Array:
	return entries.slice(-count, entries.size())

func clear_database() -> void:
	entries.clear()  # Clear in-memory entries

	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string("[]")  # Write an empty array to file
		file.close()
	else:
		push_error("Failed to open file for clearing: %s" % file_path)
