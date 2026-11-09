extends CharacterBody2D

@export var left_action = "left"
@export var right_action = "right"
@export var jump_action = "jump"

var speed = 100.0
var jump_velocity = -250.0

var dir = 0
var gravity = 908
var extra_jumps = 1

var is_alive = true

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("players")

func _physics_process(delta: float) -> void:
	
	move(delta)
	
	if is_alive:
		animations()
	
func move(delta):
	if is_alive:
		dir = Input.get_axis(left_action, right_action)
	else:
		dir = 0

	velocity.x = dir * speed
	keep_near_partner(delta)

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed(jump_action) and extra_jumps > 0 and is_alive:
		velocity.y = jump_velocity
		extra_jumps -= 1
		
	if is_on_floor():
		extra_jumps = 1
	
	move_and_slide()
	
# Impede que a dupla se afaste além do que a câmera consegue enquadrar.
func keep_near_partner(delta):
	for partner in Global.get_living_players():
		if partner == self or not is_alive:
			continue

		var distance = global_position.x + velocity.x * delta - partner.global_position.x

		if abs(distance) > Global.MAX_PLAYER_DISTANCE and sign(distance) == sign(velocity.x):
			velocity.x = 0

func animations():
	if dir != 0:
		anim.flip_h = (dir == -1)
	
	if velocity.x != 0 and is_on_floor():
		anim.play('run')
	elif velocity.x == 0 and is_on_floor():
		anim.play('idle')
	
	if not is_on_floor() and extra_jumps >= 1:
		anim.play('jump')

func die():
	if not is_alive:
		return

	is_alive = false

	anim.play('die')

	$Area2D.queue_free()
	$CollisionShape2D.queue_free()

	velocity.y = jump_velocity

	Global.on_player_died()

	await get_tree().create_timer(1.5).timeout

	queue_free()
