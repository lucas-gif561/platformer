extends Camera2D

# Câmera única da fase: enquadra os jogadores vivos e nunca sai dos limites do mapa.

const MARGIN = Vector2(80, 64)
const FOLLOW_SPEED = 8.0
const ZOOM_SPEED = 5.0
const MAX_ZOOM = 1.0
const DEATH_ZOOM = 1.5

func _ready() -> void:
	var players = Global.get_living_players()
	if not players.is_empty():
		var bounds = players_bounds(players)
		global_position = bounds.get_center()
		zoom = Vector2.ONE * target_zoom(bounds)

func _process(delta: float) -> void:
	var players = Global.get_living_players()

	if players.is_empty():
		# Todos morreram: aproxima na cena da morte até a fase reiniciar.
		zoom = zoom.lerp(Vector2.ONE * DEATH_ZOOM, smoothing(ZOOM_SPEED, delta))
		return

	var bounds = players_bounds(players)
	global_position = global_position.lerp(bounds.get_center(), smoothing(FOLLOW_SPEED, delta))
	zoom = zoom.lerp(Vector2.ONE * target_zoom(bounds), smoothing(ZOOM_SPEED, delta))

func players_bounds(players: Array) -> Rect2:
	var bounds = Rect2(players[0].global_position, Vector2.ZERO)

	for player in players:
		bounds = bounds.expand(player.global_position)

	return bounds

func target_zoom(bounds: Rect2) -> float:
	var view = get_viewport_rect().size
	var needed = view / (bounds.size + MARGIN * 2)

	# O zoom mínimo garante que a área visível nunca seja maior que o mapa.
	var map_size = Vector2(limit_right - limit_left, limit_bottom - limit_top)
	var min_zoom = max(view.x / map_size.x, view.y / map_size.y)

	return clampf(min(needed.x, needed.y), min_zoom, MAX_ZOOM)

func smoothing(speed: float, delta: float) -> float:
	return 1.0 - exp(-speed * delta)
