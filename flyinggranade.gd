extends Node2D

var speed = 720
var thrown_by: Node = null

func _physics_process(delta):
	$granade.position.x += speed * delta

	if $granade.position.x >= $impact.position.x:
		var players_hit = $impact.get_overlapping_bodies()
		for player in players_hit:
			player.hit_by_granade(self)
		
		get_parent().remove_child(self)
		
		
