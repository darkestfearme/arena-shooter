extends Label

func _process(delta):
	self.text = str(Game.red_points)
	
	if $"../player2".dead and not $"../player1".dead:
		Game.red_points += 1
		get_tree().reload_current_scene()
