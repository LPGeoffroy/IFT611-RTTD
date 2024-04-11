extends CollisionShape2D


func _ready():
	hide()

func _draw():
	var cen = Vector2(0,0)
	var rad = get_parent().get_parent().range
	var col = Color(0, 255, 0, 0.3)
	draw_circle(cen, rad, col)
