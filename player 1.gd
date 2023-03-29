extends KinematicBody2D

var dead = false
export var speed = 300
var last_direction = Vector2.UP
const bulletpath = preload("res://bullet.tscn")
var hp = 1.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if event.is_action_pressed('p1_shoot'):
		shoot()
	
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
	
func _process(delta):
	$"../leftHUD/HP".rect_scale.x = hp

func _physics_process(delta: float) -> void:
	if dead:
		return
	
	var up = Vector2.UP * Input.get_action_strength("p1_up")
	var down = Vector2.DOWN * Input.get_action_strength("p1_down")
	var left = Vector2.LEFT * Input.get_action_strength("p1_left")
	var right = Vector2.RIGHT * Input.get_action_strength("p1_right")
	
	var direction = up + down + left + right
	if direction:
		last_direction = direction
	
	$body.look_at($body.global_position + direction)
	
	move_and_slide(direction * speed)
	
	hp = clamp(hp + 0.00, 0.0, 1.0)
	
func shoot():
	var bullet = bulletpath.instance()
	bullet.shot_by = self
	
	get_parent().add_child(bullet)
	
	bullet.position = $body/gun.global_position
	bullet.rotation = last_direction.angle()

func hit_by_bullet(bullet, collision):
	hp = clamp(hp - 0.35, 0.0, 1.0)
	print("hit: ", str(hp))
	if hp == 0:
		dead = true
	
func heal(amount):
	hp += amount  
