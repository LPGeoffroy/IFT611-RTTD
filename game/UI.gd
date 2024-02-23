extends CanvasLayer


func _process(_delta):
	$Health.text = "Health: " + str(Game.Health)
	$Gold.text = "Gold: " + str(Game.Gold)
	$Ennemy.text = "Ennemies: " + str(Game.EnnemyCount)
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
