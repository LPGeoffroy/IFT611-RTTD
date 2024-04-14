extends Node2D

const waveCount : int = 10
const enemyPerWave : Array[int] = [500, 700, 900, 1100, 1600, 2500, 3400, 4300, 5200, 6100]
const startingGold : int = 1000
const spawnTime : float = 0.05

func _ready():
	var main_spawn = {"node": $PathSpawner, "path": $PathSpawner.path}
	var shortcut_spawn = {"node": $ShortcutPathSpawner, "path": $ShortcutPathSpawner.path}
	Game.load_spawn(main_spawn, shortcut_spawn)
	Game.set_ui($UI)
	Game.start_game(self)
