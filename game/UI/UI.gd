extends CanvasLayer

func _ready():
	$DialogBoxTitle.visible = false
	$DialogBox.visible = false

# Optimisation à faire ici, on n'a pas besoin de mettre à jour toutes
# ces valeurs à chaque tick
func _process(_delta):
	$Health.text = "Health: " + str(Game.health)
	$Gold.text = "Gold: " + str(Game.gold)
	$Wave.text = "Wave: " + str(Game.waveCount)
	$Enemies.text = "Enemies: " + str(Game.enemyCount)
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	$Panel/VFlowContainer/VFlowContainer2/NukePanel/Sprite2D/Label.text = "Uses : " + str(Game.nukeCount)

func game_won():
	$DialogBoxTitle.text = "You won !"
	show_dialog()
	
func game_lost():
	$DialogBoxTitle.text = "You lost.."
	show_dialog()
	
func show_dialog():
	$DialogBoxTitle.visible = true
	$DialogBox.visible = true
