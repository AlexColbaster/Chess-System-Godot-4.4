extends Controller

class_name PlayerController

func _init(player:Player) -> void:
	super(player)
	InputHandler.pressed_on_tile.connect(move)

func move(tile_pos:Vector2):
	print("Передвинулся на: %s" % tile_pos)
	super(tile_pos)
	InputHandler.block_input = true
	var tw = entity.create_tween()
	tw.tween_property(
		entity,
		"position",
		Global.tilemap.map_to_local(tile_pos),
		1
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tw.finished
	InputHandler.block_input = false 
	TurnManager.next_turn()
