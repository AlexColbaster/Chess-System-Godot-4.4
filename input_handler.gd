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
			
