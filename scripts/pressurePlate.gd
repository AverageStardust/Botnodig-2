extends Area2D

signal output(active: bool)

@onready var _sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	_sprite.frame = 1 if has_overlapping_bodies() else 0
	output.emit(has_overlapping_bodies())
