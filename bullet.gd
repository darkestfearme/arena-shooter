extends KinematicBody2D

const speed = 100

var shot_by: KinematicBody2D = null

func setup(_shot_by):
	shot_by = _shot_by

func _physics_process(delta):
	var move = Vector2.RIGHT * speed
	var collision = move_and_collide(move.rotated(rotation))
	
	if collision and collision.collider != shot_by:
		if collision.collider.has_method("hit_by_bullet"):
			collision.collider.hit_by_bullet(self, collision)
			
		get_parent().remove_child(self)
		
