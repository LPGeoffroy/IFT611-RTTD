extends StaticBody2D

@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var Bullet = preload("res://Towers/RedTower/RedBulletMain.tscn")
var WhichBullet = 0
var bulletDamage = 5
var pathName			# Le pathname du targer courant
var currTargets = []	# Les mobs actuellement dans le range
var curr				# Le target courant
var reload = 0
var range = 400


func _process(_delta):
	get_node("Upgrade/ProgressBar").global_position = self.position + Vector2(-64, -48)
	if not is_instance_valid(curr):
		find_target()
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		if timer.is_stopped() && !currTargets.is_empty():
			Shoot()
			timer.start()
		elif timer.is_paused() && !currTargets.is_empty():
			Shoot()
			timer.set_paused(false)
	update_powers()

func Shoot():
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position
	tempBullet.target = curr


func _on_tower_body_entered(body):
	if "Soldier" in body.name:
		currTargets.append(body)
		
		for mob in currTargets: 
			if not is_instance_valid(mob):
				continue
			if get_node("Tower").get_overlapping_bodies().find(mob):
				if curr == null:
					curr = mob
				else:
					if mob.get_parent().get_progress() > curr.get_parent().get_progress():
						# Attaque le mob le plus loin dans le path
						curr = mob	
		pathName = curr.get_node("../").get_parent().name


func _on_tower_body_exited(body):
	if "Soldier" in body.name:
		var index = currTargets.find(body)
		currTargets.remove_at(index)
		curr = null


func find_target():
	var tmpTarget = null
	for mob in currTargets:
		if is_instance_valid(mob):
			if tmpTarget == null:
				tmpTarget = mob
			elif mob.get_parent().get_progress() > tmpTarget.get_parent().get_progress():
				tmpTarget = mob
	if tmpTarget != null:
		curr = tmpTarget
		pathName = curr.get_node("../").get_parent().name


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node(str(Game.currentMap) + "/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
				towerPath.get_child(i).get_node("Targeting/SelectionBox").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-572,81)
		get_node("Targeting/SelectionBox").visible = !get_node("Targeting/SelectionBox").visible
		get_node("Targeting/SelectionBox").global_position = self.position + Vector2(-572,-500)


func _on_timer_timeout():
	if is_instance_valid(curr):
		Shoot()
	else:
		timer.set_paused(true)


func _on_range_pressed():
	if range <= 750:
		if Game.gold >= 10:
			Game.gold -= 10
			range += 50


func _on_attack_speed_pressed():
	if reload <= 2:
		if Game.gold >= 10:
			Game.gold -= 10
			reload += 0.1
	timer.wait_time = 3 - reload


func _on_power_pressed():
	if Game.gold >= 10:
		Game.gold -= 10
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
