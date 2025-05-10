extends Node

signal turn_changed(turn:int)
var turn := 0 :
	set(v):
		turn = v
		turn_changed.emit(turn)

func _ready() -> void:
	# ожидание пока физ движок очухается
	await get_tree().physics_frame
	await get_tree().physics_frame
	next_turn()

func next_turn():
	turn += 1
	# очистка старых точек для нажатия
	for tile:Vector2i in InputHandler.can_click_array:
		Global.tilemap.set_cell(tile, 0, Vector2i(0, 0))
	InputHandler.can_click_array = []
	# заполнение can_click_array
	for move_line:MoveLine in Global.player.line_combiner.lines:
		var pl_tile_pos := Global.tilemap.local_to_map(Global.player.position)
		var from = Global.tilemap.map_to_local(pl_tile_pos + move_line.from)
		var to = Global.tilemap.map_to_local(pl_tile_pos + move_line.to)
		var tiles_on_line = Global.get_tiles_on_line(Global.tilemap, from, to)
		for tile:Vector2i in tiles_on_line:
			if not tile in InputHandler.can_click_array and pl_tile_pos != tile:
				InputHandler.can_click_array += [tile] 
	# создание новых точек для нажатия
	for tile:Vector2i in InputHandler.can_click_array:
		Global.tilemap.set_cell(tile, 0, Vector2i(1, 0))
