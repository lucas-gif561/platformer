extends StaticBody2D

var life = 3

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('player') and life > 0:
		$AnimatedSprite2D.play("hit")
		life -= 1
		
		if life <= 0:
			$AnimatedSprite2D.queue_free()
			$CollisionShape2D.queue_free()
			$Area2D/CollisionShape2D.disabled = true
			$CPUParticles2D.restart()
			await get_tree().create_timer(1.0).timeout
			queue_free()
