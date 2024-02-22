extends CharacterBody2D

var target
var Speed = 1000
var pathName = ""
var bulletDamage

func _physics_process(delta):
	
	var pathSpawnerNode = get_tree().get_root().get_node(str(Game.CurrentMap) + "/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			# Pour solve le bug de vélocité, j'ai tabulé les trois lignes suivants dans le if. New lesser bug: Certains missiles ne bougent pas.
			velocity = global_position.direction_to(target) *Speed
			look_at(target)
			move_and_slide()

#Pas un bon fix	
	#var pathSpawnerSecondaireNode = get_tree().get_root().get_node("Map2/ShortcutPathSpawner")
	#for i in pathSpawnerSecondaireNode.get_child_count():
		#if pathSpawnerSecondaireNode.get_child(i).name == pathName:
			#target = pathSpawnerSecondaireNode.get_child(i).get_child(0).get_child(0).global_position
			## Pour solve le bug de vélocité, j'ai tabulé les trois lignes suivants dans le if. New lesser bug: Certains missiles ne bougent pas.
			#velocity = global_position.direction_to(target) *Speed
			#look_at(target)
			#move_and_slide()


func _on_area_2d_body_entered(body):
	if "Soldier A" in body.name:
		body.Health -= bulletDamage
		queue_free()
