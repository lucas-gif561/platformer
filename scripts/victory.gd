extends Control

func _ready() -> void:
	$Score.text = "PONTOS: %d" % Global.score

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		Global.start_new_game()
