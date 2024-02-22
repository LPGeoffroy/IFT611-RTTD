extends CharacterBody2D


@export var speed = 250
var Health = 10

func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() >= 0.999:
		Game.Health -= 1
		death()
		
	if Health <= 0:
		Game.Gold += 1
		death()

func death():
	print(get_parent().get_progress_ratio())
	get_parent().get_parent().queue_free()
