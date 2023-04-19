extends Label

func _process(delta):
	self.text = str(Game.blue_points)
	
	if $"../player1".dead and not $"../player2".dead:
		Game.blue_points += 1
		get_tree().reload_current_scene()
