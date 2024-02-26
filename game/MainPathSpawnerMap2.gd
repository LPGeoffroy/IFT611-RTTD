extends Node2D

@onready var path = preload("res://Mobs/Stage 2.tscn")

func _on_timer_timeout():
	Game.spawn_enemy(self, path)
