extends StaticBody2D


var Bullet = preload("res://Towers/MinigunTower/MinigunBulletMain.tscn")
var AltBullet = preload("res://Towers/MinigunTower/MinigunBulletShortcut.tscn")
var WhichBullet = 0
var bulletDamage = 1
var pathName
var currTargets = []
var curr
#@onready var mainPathSpawnerNode = get_tree().get_root().get_node(str(Game.currentMap) + "/PathSpawner")
#@onready var shortcutPathSpawnerNode = get_tree().get_root().get_node(str(Game.currentMap) + "/ShortcutPathSpawner")
var reload = 2
var range = 250

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
	#Ne sélectionne comme target que des cibles sur son path
	if "Soldier" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()

		for i in currTargets:
			if WhichBullet == 0:
				if "Soldier" in i.name:
					#var iParent = i.Path
					if not "Shortcut" in i.Path.get_name(2):
						tempArray.append(i)
			else:
				if "Soldier" in i.name:
					if "Shortcut" in i.Path.get_name(2):
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
	Shoot()


func _on_range_pressed():
	if range <= 400:
		if Game.gold >= 10:
			Game.gold -= 10
			range += 25
	
func _on_attack_speed_pressed():
	if reload <= 2.9:
		if Game.gold >= 10:
			Game.gold -= 10
			reload += 0.1
	timer.wait_time = 3 - reload
	
func _on_power_pressed():
	if bulletDamage <= 4:
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
