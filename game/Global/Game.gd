extends Node

var Gold = 100
var Health = 10
var CurrentMap = "Map2"
var EnemyCount = 0

func spawn_enemy(node, path):
	var tempPath = path.instantiate()
	node.add_child(tempPath)
	EnemyCount += 1
