extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _on_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("player"):
		
		Global.score += 1
		
		anim.play("collected")
		collision.queue_free()
		
		await get_tree().create_timer(1.0).timeout
		
		queue_free()
