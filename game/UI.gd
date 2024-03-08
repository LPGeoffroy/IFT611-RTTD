extends CanvasLayer

func _ready():
	$DialogBoxTitle.visible = false
	$DialogBox.visible = false

func _process(_delta):
	$Health.text = "Health: " + str(Game.health)
	$Gold.text = "Gold: " + str(Game.gold)
	$Wave.text = "Wave: " + str(Game.waveCount + 1)
	$Enemies.text = "Enemies: " + str(Game.enemyCount)
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())

func game_won():
	$DialogBoxTitle.text = "You won !"
	show_dialog()
	
func game_lost():
	$DialogBoxTitle.text = "You lost.."
	show_dialog()
	
func show_dialog():
	$DialogBoxTitle.visible = true
	$DialogBox.visible = true
