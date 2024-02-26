extends StaticBody2D


var Bullet = preload("res://Towers/RedBulletMain.tscn")
var AltBullet = preload("res://Towers/RedBulletShortcut.tscn")
var WhichBullet = 0
var bulletDamage = 5
var pathName
var currTargets = []
var curr

var reload = 0
var range = 400

@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var startShooting = false


func _process(_delta):
	get_node("Upgrade/ProgressBar").global_position = self.position + Vector2(-64, -48)
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		if timer.is_stopped():
			Shoot()
			timer.start()
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	update_powers()
func Shoot():
	var tempBullet = Bullet.instantiate()
	if WhichBullet == 1:
		tempBullet = AltBullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position
		
func _on_tower_body_entered(body):
	#Vise l'ennemie "Soldier A" le plus loin dans sa mire de tir, sans regarder le path qu'il prend.
	if "Soldier A" in body.name:
		#if "Shortcut 1" in body.get_parent().get_parent().get_parent():
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()

		for i in currTargets:
			if "Soldier" in i.name:
				tempArray.append(i)
		
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		
		curr = currTarget		
		pathName = currTarget.get_parent().name
		
func _on_tower_body_exited(_body):
	currTargets = get_node("Tower").get_overlapping_bodies()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node(str(Game.CurrentMap) + "/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
				towerPath.get_child(i).get_node("Targeting/SelectionBox").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-572,81)
		get_node("Targeting/SelectionBox").visible = !get_node("Targeting/SelectionBox").visible
		get_node("Targeting/SelectionBox").global_position = self.position + Vector2(-572,-500)


func _on_timer_timeout():
	Shoot()
	

func _on_range_pressed():
	if Game.Gold >= 10:
		Game.Gold -= 10
		range += 30
	
func _on_attack_speed_pressed():
	if reload <= 2:
		if Game.Gold >= 10:
			Game.Gold -= 10
			reload += 0.1
	timer.wait_time = 3 - reload
	
func _on_power_pressed():
	if Game.Gold >= 10:
		Game.Gold -= 10
		bulletDamage += 1

func update_powers():
	get_node("Upgrade/Upgrade/HBoxContainer/Range/Label").text = str(range)
	get_node("Upgrade/Upgrade/HBoxContainer/AttackSpeed/Label").text = str(3 - reload)
	get_node("Upgrade/Upgrade/HBoxContainer/Power/Label").text = str(bulletDamage)
	
	get_node("Tower/CollisionShape2D").shape.radius = range


func _on_range_mouse_entered():
	get_node("Tower/CollisionShape2D").show()


func _on_range_mouse_exited():
	get_node("Tower/CollisionShape2D").hide()


func _on_main_path_pressed():
	WhichBullet = 0

func _on_shortcut_1_pressed():
	WhichBullet = 1
