extends Node

@onready var tilemap:TileMapLayer = get_tree().current_scene.get_node("TileMapLayer")
@onready var player:Player = get_tree().current_scene.get_node("Player")

# получение тайлов на отрезке
func get_tiles_on_line(from: Vector2, to:Vector2) -> Array:
	var tiles := []
	var space = tilemap.get_world_2d().direct_space_state
	var params = PhysicsRayQueryParameters2D.new()
	params.from = from
	params.to = to
	params.collide_with_areas = true
	var result = space.intersect_ray(params)
	var direction = (to - from).normalized()
	while result:
		var tile_pos = tilemap.local_to_map(result.position)
		if not tile_pos in tiles:
			tiles.append(tile_pos)
		# сдвигаем начало луча чуть дальше точки столкновения
		params.from += direction
		result = space.intersect_ray(params)
	
	return tiles
