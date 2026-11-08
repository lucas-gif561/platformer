extends Area2D

@export var level = ""

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		
		await get_tree().create_timer(1.0).timeout
		
		get_tree().change_scene_to_file(level)
