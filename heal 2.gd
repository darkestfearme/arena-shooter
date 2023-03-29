extends Area2D

export var power: float = 0.2

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.has_method("heal"):
			body.heal(delta * power)
