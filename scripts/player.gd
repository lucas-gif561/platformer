extends CharacterBody2D

var speed = 100.0
var jump_velocity = -250.0

var dir = 0
var gravity = 908
var extra_jumps = 1

var is_alive = true

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	move(delta)
	
	if is_alive:
		animations()
	
func move(delta):
	if is_alive:
		dir = Input.get_axis('left', 'right')
	else:
		dir = 0
		
	velocity.x = dir * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed('jump') and extra_jumps > 0 and is_alive:
		velocity.y = jump_velocity
		extra_jumps -= 1
		
	if is_on_floor():
		extra_jumps = 1
	
	move_and_slide()
	
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
	is_alive = false
	
	anim.play('die')
	
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	
	velocity.y = jump_velocity
	
	$Camera2D.zoom = Vector2(1.5, 1.5)
	Engine.time_scale = 0.5
	
	await get_tree().create_timer(1.5).timeout
	
	Engine.time_scale = 1.0
	
	get_tree().reload_current_scene()
	
	Global.score = 0
	
	#move_child($Camera2D, -1)
	# $Camera2D.global_position = global_position
