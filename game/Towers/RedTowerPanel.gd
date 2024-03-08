extends Panel


@onready var tower = preload("res://Towers/RedBulletTower.tscn")
var currTile

func _on_gui_input(event):
	if Game.gold >= 10:
		var tempTower = tower.instantiate()
		if event is InputEventMouseButton and event.button_mask == 1:
			#print("Left button down")
			add_child(tempTower)
			
			tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			tempTower.global_position = self.get_global_mouse_position() #event.global_position
			tempTower.scale = Vector2(0.32, 0.32)
			
			
		elif event is InputEventMouseMotion and event.button_mask == 1:
			#print("Left button up")
			if get_child_count() > 1:	
				
				get_child(1).global_position = self.get_global_mouse_position() #event.global_position
			
				var mapPath = get_tree().get_root().get_node(str(Game.currentMap) + "/TileMap")
				var tile = mapPath.local_to_map(get_global_mouse_position())
				currTile = mapPath.get_cell_atlas_coords(0, tile, false)
				var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
				
				if (currTile == Vector2i(4,5)):
					if (targets.size() > 0):
						get_child(1).get_node("Area").modulate = Color(255,255,255, 0.3)
					else:
						get_child(1).get_node("Area").modulate = Color(0,255,0, 0.3)
				else:
					get_child(1).get_node("Area").modulate = Color(255, 255, 255, 0.3)
					
		elif event is InputEventMouseButton and event.button_mask == 0:
			#print("Left button up")
			if event.global_position.x >= 2944: #2304
				if get_child_count() > 1:	
					get_child(1).queue_free()
			else:
				if get_child_count() > 1:	
					get_child(1).queue_free()
				if currTile == Vector2i(4,5):
					var path = get_tree().get_root().get_node(str(Game.currentMap) + "/Towers")
					var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
					if (targets.size() < 1):
						path.add_child(tempTower)
						tempTower.global_position = self.get_global_mouse_position() #event.global_position
						tempTower.get_node("Area").hide()
						Game.gold -= 10
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
