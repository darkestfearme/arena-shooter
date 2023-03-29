extends Label

func _physics_process(delta):
	if $"../player1".dead:
		show()
