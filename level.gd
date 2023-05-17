extends Node2D

const granade_scene = preload("res://pickablegranade.tscn")

func _physics_process(delta):
	var granade = get_node_or_null("granade")
	if not granade:
		granade = granade_scene.instance()
		add_child(granade)
		
		var world = get_world_2d()
		var space = world.direct_space_state
		
		while true:
			var x = randi() % 1920
			var y = randi() % 1080
			granade.position = Vector2(x, y)
			
			var query = Physics2DShapeQueryParameters.new()
			query.collide_with_areas = true
			query.collide_with_bodies = true
			query.collision_layer = 16
			query.shape_rid = granade.get_node("granade shape").shape.get_rid()
			query.transform = granade.global_transform
			
			var walls = space.intersect_shape(query, 1)
			
			if not walls:
				break
