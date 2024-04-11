extends CharacterBody2D


@export var speed = 200
var Health = 10
var Path

func init(_speed : int, _health : int, _scale : int):
	speed = _speed
	Health = _health
	$TowerDefenseTile245.scale.x= _scale
	$TowerDefenseTile245.scale.y = _scale
	
func _physics_process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	var whatIsParent = get_parent().get_path()
	Path = whatIsParent
	
	
	if get_parent().get_progress_ratio() >= 0.999:
		Game.modify_health(-1)
		death()
		
	if Health <= 0:
		Game.modify_gold(1)
		death()

func death():
	get_parent().get_parent().queue_free()
	Game.modify_enemy_count(-1)
