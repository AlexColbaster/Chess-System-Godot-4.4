extends Node

@onready var tilemap:TileMapLayer = get_tree().current_scene.get_node("TileMapLayer")
@onready var player:Player = get_tree().current_scene.get_node("Player")

# насколько точка в пространстве далека от ближайшего узла сетки тайлмапа
func get_grid_delta(point:Vector2, tile_point:Vector2i):
	return tilemap.map_to_local(tile_point).distance_squared_to(point)

# получение тайлов на отрезке
func get_tiles_on_line(move_line:MoveLine, pl_tile_pos:Vector2i) -> Array:
	var global_tile_to = pl_tile_pos + move_line.to
	var global_tile_from = pl_tile_pos + move_line.from
	var to = tilemap.map_to_local(global_tile_to)
	var from = tilemap.map_to_local(global_tile_from)
	
	var tiles := []
	var direction = (to - from).normalized()

	for i in int(from.distance_to(to)):
		var tile_pos = tilemap.local_to_map(from)
		if tilemap.get_cell_source_id(tile_pos) != -1 and not tile_pos in tiles:
			if get_grid_delta(from, tile_pos) < 4:
				tiles.append(tile_pos)
		from += direction
	
	return tiles
