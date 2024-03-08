extends Button

const MAP_NAME : String = "Map2"
const MAP_LOCATION : String = "res://Map2.tscn"

func _on_pressed():
	Game.load_map(MAP_NAME, MAP_LOCATION)
