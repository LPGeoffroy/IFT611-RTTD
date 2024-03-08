extends Node

# Variables du jeu
var ui : CanvasLayer
var gold : int
var health : int
var enemyCount : int
var enemySpawned : int
var waveCount : int

# Variables de la map
var currentMap : String
var currentMapNode : Node2D
var mainSpawn : Dictionary
var shortcutSpawn : Dictionary

# Timers
var restTimer : Timer = Timer.new()
var spawnTimer : Timer = Timer.new()
var restTime  : int = 2		# temps entre les waves d'ennemies
var spawnTime : float = 1		# interal de temps entre les spawn d'ennemies


func start_game(node):
	initialize()
	currentMapNode = node
	currentMapNode.add_child(restTimer)
	restTimer.wait_time = restTime
	restTimer.one_shot = true
	restTimer.timeout.connect(start_wave)
	restTimer.start()

func initialize():
	gold = 100
	health = 10
	enemyCount = 0
	enemySpawned = 0
	waveCount = 0
	restTimer = Timer.new()
	spawnTimer = Timer.new()
	
func load_map(map, mapPath):
	currentMap = map
	get_tree().change_scene_to_file(mapPath)
	
func load_spawn(_mainSpawn, _shortcutSpawn):
	mainSpawn = _mainSpawn
	shortcutSpawn = _shortcutSpawn

func set_ui(_ui):
	ui = _ui
	
func start_wave():
	enemySpawned = 0
	currentMapNode.add_child(spawnTimer)
	spawnTimer.wait_time = spawnTime
	spawnTimer.timeout.connect(spawn_ennemy)
	spawnTimer.start()

func end_wave():
	spawnTimer.stop()
	waveCount += 1
	if waveCount < currentMapNode.waveCount:
		restTimer.start()
	else:
		pass

func spawn_ennemy():
	if enemySpawned < currentMapNode.enemyPerWave[waveCount]:
		var random_int = randi() % 100
		if random_int < 70:
			var tempPath = mainSpawn["path"].instantiate()
			mainSpawn["node"].add_child(tempPath)
		else:
			var tempPath = shortcutSpawn["path"].instantiate()
			shortcutSpawn["node"].add_child(tempPath)
			shortcutSpawn["node"]
		enemyCount += 1	
		enemySpawned += 1
	else:
		end_wave()

func despawn_ennemies():
	var main_path = mainSpawn["node"]
	var shortcut_path = shortcutSpawn["node"]
	
	for child in main_path.get_children():
		child.queue_free()
	
	for child in shortcut_path.get_children():
		child.queue_free()

func modify_health(amount):
	health += amount
	if health <= 0:
		game_lost()

func modify_gold(amount):
	gold += amount

func modify_enemy_count(amount):
	enemyCount += amount

func game_won():
	ui.game_won()
	restTimer.stop()
	spawnTimer.stop()
	despawn_ennemies()
	
func game_lost():
	ui.game_lost()
	restTimer.stop()
	spawnTimer.stop()
	despawn_ennemies()
