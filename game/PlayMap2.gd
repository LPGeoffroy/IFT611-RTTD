extends Button


func _on_pressed():
	Game.CurrentMap = "Map2"
	get_tree().change_scene_to_file("res://Map2.tscn")
