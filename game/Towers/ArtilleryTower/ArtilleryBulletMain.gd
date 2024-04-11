extends CharacterBody2D

var target
var Speed = 500
var pathName = ""
var bulletDamage
var timer := Timer.new()

func _physics_process(_delta):
	var pathSpawnerNode = get_tree().get_root().get_node(str(Game.currentMap) + "/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			# Pour solve le bug de vélocité, j'ai tabulé les trois lignes suivants dans le if.
			velocity = global_position.direction_to(target) *Speed
			look_at(target)
			move_and_slide()
			# Timer pour que les missiles disparaissent apres x secondes
			timer.wait_time = 3 # 3 secondes
			timer.one_shot = true # don't loop, run once
			timer.autostart = true # start timer when added to a scene
			timer.timeout.connect(_on_timer_timeout)
			add_child(timer)

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body):
	var targets = get_node("AoE").get_overlapping_bodies()
	for target in targets:
		if "Soldier A" in target.name:
			target.Health -= bulletDamage
			queue_free()

