extends Camera2D

@export var margin: float = 1.1

func _ready() -> void:
	await get_tree().process_frame
	_adjust_camera()

func _adjust_camera() -> void:
	var tilemap = get_node_or_null("../GameTileMap")
	if tilemap == null:
		return

	var bounds = Rect2()
	var has_bounds = false

	for child in tilemap.get_children():
		if child is TileMapLayer:
			var used_rect = child.get_used_rect()
			if used_rect.size.x > 0 and used_rect.size.y > 0:
				var layer_rect = Rect2(child.position + Vector2(used_rect.position * 16), Vector2(used_rect.size * 16))
				if has_bounds:
					bounds = bounds.merge(layer_rect)
				else:
					bounds = layer_rect
					has_bounds = true

	if not has_bounds:
		return

	var viewport_size = get_viewport_rect().size
	var zoom_x = viewport_size.x / (bounds.size.x * margin)
	var zoom_y = viewport_size.y / (bounds.size.y * margin)
	var final_zoom = min(zoom_x, zoom_y)

	zoom = Vector2(final_zoom, final_zoom)
	position = bounds.position + bounds.size / 2.0
