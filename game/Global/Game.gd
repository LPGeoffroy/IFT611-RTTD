extends Node

var Gold = 100
var Health = 10
var CurrentMap = "Map2"
var EnnemyCount = 0

func spawn_ennemy(node, path):
	var tempPath = path.instantiate()
	node.add_child(tempPath)
	EnnemyCount += 1
