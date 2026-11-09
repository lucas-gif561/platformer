extends Node

const FIRST_LEVEL = "res://scenes/level_1.tscn"
const MAX_PLAYER_DISTANCE = 360.0
const DEATH_DELAY = 1.0
const FLAG_DELAY = 1.0

var score = 0
var level_start_score = 0

var changing_scene = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and not changing_scene:
		if not get_tree().get_nodes_in_group("players").is_empty():
			restart_level()

func get_living_players() -> Array:
	return get_tree().get_nodes_in_group("players").filter(func(player): return player.is_alive)

# A fase só reinicia quando não sobra nenhum jogador vivo.
func on_player_died() -> void:
	if changing_scene or not get_living_players().is_empty():
		return

	changing_scene = true
	Engine.time_scale = 0.5

	await get_tree().create_timer(DEATH_DELAY).timeout

	restart_level()

func restart_level() -> void:
	score = level_start_score
	finish_scene_change()
	get_tree().reload_current_scene()

func finish_level(next_scene: String) -> void:
	if changing_scene:
		return

	changing_scene = true

	await get_tree().create_timer(FLAG_DELAY).timeout

	level_start_score = score
	finish_scene_change()
	get_tree().change_scene_to_file(next_scene)

func start_new_game() -> void:
	score = 0
	level_start_score = 0
	finish_scene_change()
	get_tree().change_scene_to_file(FIRST_LEVEL)

func finish_scene_change() -> void:
	changing_scene = false
	Engine.time_scale = 1.0
