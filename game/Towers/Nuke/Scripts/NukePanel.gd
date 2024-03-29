extends Panel


@onready var nuke = preload("res://Towers/Nuke/Scenes/Nuke.tscn")
var currTile

func _on_gui_input(event):
	if not has_nuke():
		return
	var tempNuke = nuke.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		add_child(tempNuke)
		tempNuke.process_mode = Node.PROCESS_MODE_DISABLED
		tempNuke.global_position = self.get_global_mouse_position() #event.global_position
		tempNuke.scale = Vector2(0.75, 0.75)
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:	
			get_child(1).global_position = self.get_global_mouse_position() #event.global_position
		
			var mapPath = get_tree().get_root().get_node(str(Game.currentMap) + "/TileMap")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(0, tile, false)
	# Le joueur "release left mouse button"
	elif event is InputEventMouseButton and event.button_mask == 0:
		if event.global_position.x >= 2944: #2304
			if get_child_count() > 1:	
				get_child(1).queue_free()
		else:
			if get_child_count() > 1:	
				get_child(1).queue_free()
			if currTile == Vector2i(4,5):
				var path = get_tree().get_root().get_node(str(Game.currentMap) + "/Towers")
				# path.add_child(tempNuke)
				tempNuke.global_position = self.get_global_mouse_position() #event.global_position
				tempNuke.get_node("Area").hide()
				var targets = get_child(1).get_node("NukeArea").get_overlapping_bodies()
				Game.use_nuke()
				tempNuke.explode(targets)
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()

func has_nuke():
	return Game.nukeCount > 0
