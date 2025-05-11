extends Node

@onready var tilemap:TileMapLayer = get_tree().current_scene.get_node("TileMapLayer")
@onready var player:Player = get_tree().current_scene.get_node("Player")

# получение тайлов на отрезке
func get_tiles_on_line(move_line:MoveLine, pl_tile_pos:Vector2i) -> Array:
	var global_tile_to = pl_tile_pos + move_line.to
	var global_tile_from = pl_tile_pos + move_line.from
	var to = tilemap.map_to_local(global_tile_to)
	var from = tilemap.map_to_local(global_tile_from)
	var tiles := [global_tile_to, global_tile_from]
	var space = tilemap.get_world_2d().direct_space_state
	var params = PhysicsRayQueryParameters2D.new()
	
	params.from = from
	params.to = to
	params.collide_with_areas = true
	var direction = (to - from).normalized()
	var result = space.intersect_ray(params)
	while result:
		var tile_pos = tilemap.local_to_map(result.position)
		if not tile_pos in tiles:
			tiles.append(tile_pos)
		# сдвигаем начало луча чуть дальше точки столкновения
		params.from += direction
		result = space.intersect_ray(params)
	
	return tiles
