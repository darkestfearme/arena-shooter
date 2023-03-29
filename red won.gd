extends Label

func _physics_process(delta):
	if $"../player2".dead:
		show()
