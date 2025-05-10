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
	# обновление can_click_array
	InputHandler.update_can_click_array()
	# создание новых точек для нажатия
	for tile:Vector2i in InputHandler.can_click_array:
		Global.tilemap.set_cell(tile, 0, Vector2i(1, 0))
