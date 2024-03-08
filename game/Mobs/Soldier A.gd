extends CharacterBody2D


@export var speed = 200
var Health = 10

func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() >= 0.999:
		Game.modify_health(-1)
		death()
		
	if Health <= 0:
		Game.modify_gold(1)
		death()

func death():
	get_parent().get_parent().queue_free()
	Game.modify_enemy_count(-1)
