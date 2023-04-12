extends Area2D

export var power: float = 0.2

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if "dead" in body:
			if body.dead:
				continue
		
		if body.has_method("heal"):
			body.heal(delta * power)
