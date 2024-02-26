extends CanvasLayer


func _process(_delta):
	$Health.text = "Health: " + str(Game.Health)
	$Gold.text = "Gold: " + str(Game.Gold)
	$Enemies.text = "Enemies: " + str(Game.EnemyCount)
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
