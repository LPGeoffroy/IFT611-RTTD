extends "res://Towers/RedTower/RedBulletTower.gd"


func _ready():
	super._ready()
	Bullet = preload("res://Towers/ArtilleryTower/ArtilleryBulletMain.tscn")
	bulletDamage = 5
	reload = -2
	range = 1000

func _on_range_pressed():
	if range <= 2400:
		if Game.gold >= 10:
			Game.gold -= 10
			range += 100

func _on_attack_speed_pressed():
	if reload <= 0:
		if Game.gold >= 10:
			Game.gold -= 10
			reload += 0.5
	timer.wait_time = 3 - reload

func _on_power_pressed():
	if bulletDamage <= 9:
		if Game.gold >= 10:
			Game.gold -= 10
			bulletDamage += 1

func update_powers():
	get_node("Upgrade/Upgrade/HBoxContainer/Range/Label").text = str(range)
	get_node("Upgrade/Upgrade/HBoxContainer/AttackSpeed/Label").text = str(3 - reload)
	get_node("Upgrade/Upgrade/HBoxContainer/Power/Label").text = str(bulletDamage)
	get_node("Tower/CollisionShape2D").shape.radius = range
