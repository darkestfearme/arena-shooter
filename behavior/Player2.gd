extends Node

func _physics_process(delta):
	$"..".move_up = Input.get_action_strength("p2_up")
	$"..".move_down = Input.get_action_strength("p2_down")
	$"..".move_left = Input.get_action_strength("p2_left")
	$"..".move_right = Input.get_action_strength("p2_right")

func _process(delta):
	$"../../rightHUD/HP".rect_scale.x = $"..".hp

func _input(event):
	if event.is_action_pressed("p2_shoot"):
		$"..".shoot = true
