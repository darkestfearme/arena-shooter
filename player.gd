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
const granadepath = preload("res://flyinggranade.tscn")
var hp = 1.0
var ammo = 10
var granade = false
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
			
			if granade:
				granade = false
				throw_granade()
				$"body/granade-aim".hide()
			else:
				if ammo > 0:
					ammo -= 1
					shoot()
					$Behavior.bullet_shot()
				else:
					reloading_time = 3
	
	if reloading_time > 0:
		reloading_time -= delta
		if reloading_time < 0:
			reloading_time = 0
			ammo = 10
			$Behavior.reload()
			
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
	
	var items_to_pick = $picker.get_overlapping_bodies()
	for item in items_to_pick:
		if "granade" in item.name:
			$"body/granade-aim".show()
			granade = true
		
		# Both may pick it at the same moment.
		var parent = item.get_parent()
		if parent:
			parent.remove_child(item)
	
func shoot():
	var bullet = bulletpath.instance()
	bullet.shot_by = self
	
	get_parent().add_child(bullet)
	
	bullet.position = $body/gun.global_position
	bullet.rotation = last_direction.angle()

func throw_granade():
	var granade = granadepath.instance()
	granade.thrown_by = self
	
	get_parent().add_child(granade)
	
	granade.position = $body.global_position
	granade.rotation = last_direction.angle()

func hit_by_bullet(bullet, collision):
	hp = clamp(hp - 0.35, 0.0, 1.0)
	if hp == 0:
		dead = true

func hit_by_granade(granade):
	hp = clamp(hp - 1.0, 0.0, 1.0)
	if hp == 0:
		dead = true

func heal(amount):
	hp += amount  

