extends Label

func _process(delta):
	if $"../player2".dead and not $"../player1".dead:
		show()
	else:
		hide()
