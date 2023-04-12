extends Node

func _physics_process(delta):
	$"..".move_up = Input.get_action_strength("p1_up")
	$"..".move_down = Input.get_action_strength("p1_down")
	$"..".move_left = Input.get_action_strength("p1_left")
	$"..".move_right = Input.get_action_strength("p1_right")

func _process(delta):
	$"../../leftHUD/HP".rect_scale.x = $"..".hp

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("p1_shoot"):
		$"..".shoot = true
