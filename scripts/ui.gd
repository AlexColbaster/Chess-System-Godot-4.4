extends CanvasLayer

func _ready() -> void:
	TurnManager.turn_changed.connect(func (t): $Panel/Turn.text = "Ход: %s" % t)
