extends Node

@onready var tilemap:TileMapLayer = get_tree().current_scene.get_node("TileMapLayer")
@onready var player:Player = get_tree().current_scene.get_node("Player")

# получение тайлов на отрезке
func get_tiles_on_line(move_line:MoveLine, pl_tile_pos:Vector2i) -> Array:
	var global_tile_to = pl_tile_pos + move_line.to
	var global_tile_from = pl_tile_pos + move_line.from
	var to = tilemap.map_to_local(global_tile_to)
	var from = tilemap.map_to_local(global_tile_from)
	var tiles := []
	var space = tilemap.get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	
	var direction = (to - from).normalized()

	query.position = from
	for i in int(from.distance_to(to)):
		var result = space.intersect_point(query)
		if result:
			var tile_pos = tilemap.local_to_map(query.position)
			if not tile_pos in tiles:
				tiles.append(tile_pos)
		query.position += direction
	
	return tiles
