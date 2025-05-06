extends TabContainer

@onready var dash = $Dashboard

func _on_tab_changed(tab: int) -> void:
	dash.refresh()
