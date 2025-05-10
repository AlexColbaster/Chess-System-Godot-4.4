extends Node2D

class_name Player

@export var line_combiner:LineCombiner
@onready var controller := PlayerController.new(self)
