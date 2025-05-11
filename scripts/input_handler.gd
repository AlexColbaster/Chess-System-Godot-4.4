extends Node2D
"""
INPUT SINGLETON
"""
signal pressed_on_tile(Vector2)
var block_input := false
var can_click_array := []

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and not block_input:
			var tile := Global.tilemap.local_to_map(get_global_mouse_position())
			if tile in can_click_array:
				pressed_on_tile.emit(tile)
			
func update_can_click_array():
	can_click_array = []
	for move_line:MoveLine in Global.player.line_combiner.lines:
		var pl_tile_pos := Global.tilemap.local_to_map(Global.player.position)
		var tiles_on_line = Global.get_tiles_on_line(move_line, pl_tile_pos)
		for tile:Vector2i in tiles_on_line:
			if pl_tile_pos != tile:
				can_click_array += [tile] 
