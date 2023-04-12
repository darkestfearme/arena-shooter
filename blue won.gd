extends Label

func _process(delta):
	if $"../player1".dead and not $"../player2".dead:
		show()
	else:
		hide()
