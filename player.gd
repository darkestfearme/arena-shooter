extends KinematicBody2D

export var color: Color = Color.red

var move_up: float = 0.0
var move_down: float = 0.0
var move_left: float = 0.0
var move_right: float = 0.0
var shoot: bool = false

var dead = false
var speed = 505
var last_direction = Vector2.UP
const bulletpath = preload("res://bullet.tscn")
var hp = 1.0
var ammo = 10
var reloading_time = 0

func _ready():
	$body/look.modulate = color
	
func _process(delta):
	if reloading_time > 0.0:
		$reloading.show()
		$reloading.rect_scale.x = reloading_time / 3.0
	else:
		$reloading.hide()

func _physics_process(delta: float) -> void:
	if dead:
		return
	
	if reloading_time == 0:
		if shoot:
			shoot = false
			if ammo > 0:
				ammo -= 1
				shoot()
			else:
				reloading_time = 3
	
	if reloading_time > 0:
		reloading_time -= delta
		if reloading_time < 0:
			reloading_time = 0
			ammo = 10
	
	var up = Vector2.UP * move_up
	var down = Vector2.DOWN * move_down
	var left = Vector2.LEFT * move_left
	var right = Vector2.RIGHT * move_right
	
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
	if hp == 0:
		dead = true
	
func heal(amount):
	hp += amount  

