extends CharacterBody2D

var target
var targetPosition
var Speed = 1000
var pathName = ""
var bulletDamage
var timer := Timer.new()

func _physics_process(_delta):
	var pathSpawnerNode
	if not "Shortcut" in pathName:
		pathSpawnerNode = get_tree().get_root().get_node(str(Game.currentMap) + "/PathSpawner")
	else:
		pathSpawnerNode = get_tree().get_root().get_node(str(Game.currentMap) + "/ShortcutPathSpawner")
		
	if not is_instance_valid(target):	# TODO : Trouver un autre target au lieu de détruire le missile
		print("Target dead")
		queue_free()
		return
	targetPosition = target.global_position
	
	# Pour solve le bug de vélocité, j'ai tabulé les trois lignes suivants dans le if. New lesser bug: Certains missiles ne bougent pas.
	velocity = global_position.direction_to(targetPosition) * Speed
	look_at(targetPosition)
	move_and_slide()
	# Timer pour que les missiles disparraissent apres x secondes
	timer.wait_time = 1.5 # 1.5 seconds
	timer.one_shot = true # don't loop, run once
	timer.autostart = true # start timer when added to a scene
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body):
	if "Soldier" in body.name:
		body.Health -= bulletDamage
		queue_free()
