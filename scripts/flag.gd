extends Area2D

@export var level = ""

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.finish_level(level)
