extends Node

var damage : int = 9999
	
func explode(targets):
	for target in targets:
		if "Soldier" in target.name:
			target.Health -= damage
			queue_free()
			
