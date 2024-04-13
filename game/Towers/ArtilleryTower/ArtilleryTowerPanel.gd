extends "res://Towers/RedTower/RedTowerPanel.gd"


func _ready():
	super._ready()
	tower = preload("res://Towers/ArtilleryTower/ArtilleryTower.tscn")
	towerCost = 40
