extends Area2D

# Fica abaixo do mapa: quem cai em um buraco morre ao entrar nesta área.
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.get_parent().die()
