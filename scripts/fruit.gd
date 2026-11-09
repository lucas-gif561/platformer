extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

var collected = false

func _on_area_entered(area: Area2D) -> void:
	
	# Dois jogadores podem tocar a mesma fruta no mesmo instante.
	if area.is_in_group("player") and not collected:

		collected = true
		Global.score += 1

		anim.play("collected")
		collision.queue_free()
		
		await get_tree().create_timer(1.0).timeout
		
		queue_free()
