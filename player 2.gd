extends KinematicBody2D

var dead = false
export var speed = 300
var last_direction = Vector2.UP
var hp = 1.0
const bulletpath = preload("res://bullet.tscn")

func _input(event: InputEvent) -> void:
	
	if event.is_action("ui_cancel"):
		get_tree().quit()
	
	if event.is_action_pressed('p2_shoot'):
		shoot()

func _process(delta):
	$"../rightHUD/HP".rect_scale.x = hp


func _physics_process(delta: float) -> void:
	if dead:
		return
	var up = Vector2.UP * Input.get_action_strength("p2_up")
	var down = Vector2.DOWN * Input.get_action_strength("p2_down")
	var left = Vector2.LEFT * Input.get_action_strength("p2_left")
	var right = Vector2.RIGHT * Input.get_action_strength("p2_right")
	 
	
	var direction = up + down + left + right
	if direction:
		last_direction = direction
	
	$body.look_at($body.global_position + direction)
	
	move_and_slide(direction * speed)
	
	hp = clamp(hp + 0.000, 0.0, 1.0)

func hit_by_bullet(bullet, collision):
	hp = clamp(hp - 0.35, 0.0, 1.0)
	if hp == 0.0:
		dead = true

func heal(amount):
	hp += amount

func shoot():
	var bullet = bulletpath.instance()
	bullet.shot_by = self
	
	get_parent().add_child(bullet)
	
	bullet.position = $body/gun.global_position
	bullet.rotation = last_direction.angle()
