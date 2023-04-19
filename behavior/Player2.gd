extends Node

func _physics_process(delta):
	$"..".move_up = Input.get_action_strength("p2_up")
	$"..".move_down = Input.get_action_strength("p2_down")
	$"..".move_left = Input.get_action_strength("p2_left")
	$"..".move_right = Input.get_action_strength("p2_right")

func _process(delta):
	$"../../rightHUD/HBox/HP".rect_scale.x = $"..".hp

func _input(event):
	if event.is_action_pressed("p2_shoot"):
		$"..".shoot = true

func bullet_shot():
	for child in $"../../rightHUD/HBox".get_children():
		if child.name.begins_with("Bullet"):
			if child.visible:
				child.hide()
				break

func reload():
	for child in $"../../rightHUD/HBox".get_children():
		if child.name.begins_with("Bullet"):
			child.show()
