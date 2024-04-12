extends Node2D

const waveCount : int = 10
const enemyPerWave : Array[int] = [5, 7, 9, 11, 16, 25, 34, 43, 52, 61]


func _ready():
	var main_spawn = {"node": $PathSpawner, "path": $PathSpawner.path}
	var shortcut_spawn = {"node": $ShortcutPathSpawner, "path": $ShortcutPathSpawner.path}
	Game.load_spawn(main_spawn, shortcut_spawn)
	Game.set_ui($UI)
	Game.start_game(self)
