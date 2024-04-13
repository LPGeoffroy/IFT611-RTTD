extends "res://Towers/RedTower/RedTowerPanel.gd"


func _ready():
	super._ready()
	tower = preload("res://Towers/MinigunTower/MinigunTower.tscn")
	towerCost = 25
