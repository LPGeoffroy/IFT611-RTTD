extends Node

# Variables du jeu
var ui : CanvasLayer
var gold : int
var health : int
var enemyCount : int
var enemySpawned : int
var waveCount : int
var nukeCount : int

# Variables de la map
var currentMap : String
var currentMapNode : Node2D
var mainSpawn : Dictionary
var shortcutSpawn : Dictionary

# Timers
var highResTimer : HighResTimer
var restTimer : Timer 
var spawnTimer : Timer
var checkGameWonTimer : Timer
var restTime  : int = 1		# temps entre les waves d'ennemies
var spawnTime : float = 1		# interal de temps entre les spawn d'ennemies

# Player
class Player:
	var spentGold : int = 0
	var currentTowers : int = 0
	var upgrades : int = 0
	var power : float = 0
var player : Player

func _ready():
	print("Game.gd is getting ready")

func start_game(node):
	initialize_variables()
	initialize_timers()
	currentMapNode = node
	currentMapNode.add_child(restTimer)
	restTimer.start()

func initialize_variables():
	gold = 200
	health = 10
	enemyCount = 0
	enemySpawned = 0
	waveCount = 0
	nukeCount = 1
	player = Player.new()

func initialize_timers():
	highResTimer = HighResTimer.new()
	highResTimer.start_timer()
	spawnTimer = Timer.new()
	spawnTimer.wait_time = spawnTime
	spawnTimer.timeout.connect(spawn_ennemy)
	restTimer = Timer.new()
	restTimer.wait_time = restTime
	restTimer.one_shot = true
	restTimer.timeout.connect(start_wave)
	checkGameWonTimer = Timer.new()
	checkGameWonTimer.wait_time = 1
	checkGameWonTimer.timeout.connect(check_game_won)
	print("Initiazed timers in ", highResTimer.stop_timer(), " ms")


func load_map(map, mapPath):
	currentMap = map
	get_tree().change_scene_to_file(mapPath)
	
func load_spawn(_mainSpawn, _shortcutSpawn):
	mainSpawn = _mainSpawn
	shortcutSpawn = _shortcutSpawn

func set_ui(_ui):
	ui = _ui
	
func start_wave():
	waveCount += 1
	enemySpawned = 0
	currentMapNode.add_child(spawnTimer)
	spawnTimer.start()

func end_wave():
	spawnTimer.stop()
	if waveCount < currentMapNode.waveCount:
		restTimer.start()
	else:
		currentMapNode.add_child(checkGameWonTimer)
		checkGameWonTimer.start()

func spawn_ennemy():
	if enemySpawned < currentMapNode.enemyPerWave[waveCount-1]:
		if(player.currentTowers > 0):
			var random_int = randi() % 100
			if random_int < 70:
				var tempPath = mainSpawn["path"].instantiate()
				if(random_int < 25 && player.power > 100):
					tempPath.get_child(0).get_child(0).init(100, 50, 5)
				mainSpawn["node"].add_child(tempPath)
			else:
				var tempPath = shortcutSpawn["path"].instantiate()
				if(random_int > 90 && player.power > 100):
					tempPath.get_child(0).get_child(0).init(100, 50, 5)
				shortcutSpawn["node"].add_child(tempPath)
			enemyCount += 1	
			enemySpawned += 1
	else:
		if(enemyCount < 2):
			end_wave()

func evaluate_player_power():
	player.power = player.spentGold + (player.currentTowers * 2) + (player.upgrades * 2)
	print(player.power)
	
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

func check_game_won():
	if enemyCount == 0:
		game_won()

func game_won():
	ui.game_won()
	restTimer.stop()
	spawnTimer.stop()
	checkGameWonTimer.stop()
	despawn_ennemies()
	
func game_lost():
	ui.game_lost()
	restTimer.stop()
	spawnTimer.stop()
	checkGameWonTimer.stop()
	despawn_ennemies()

func use_nuke():
	if nukeCount > 0:
		nukeCount -= 1
