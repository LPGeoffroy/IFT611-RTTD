extends "res://Towers/RedTower/RedBulletMain.gd"


func _ready():
	super._ready()
	speed = 750
	timerWaitTime = 3

func _on_area_2d_body_entered(body):
	#if "Soldier" in body.name:
	var targets = get_node("AoE").get_overlapping_bodies()
	for target in targets:
		if "Soldier" in target.name:
			target.Health -= bulletDamage
			queue_free()
			
