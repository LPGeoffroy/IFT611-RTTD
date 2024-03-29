extends Button

const MAP_NAME : String = "Map1"
const MAP_LOCATION : String = "res://Maps/Map1.tscn"

func _on_pressed():
	Game.load_map(MAP_NAME, MAP_LOCATION)
