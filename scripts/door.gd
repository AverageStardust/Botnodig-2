extends StaticBody2D
class_name Door

@export var input: Node

const OPEN_SPEED = 4.5
const CLOSE_SPEED = 7.0

var _is_open: bool = false
var _frame_float: float = 0

@onready var _sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if input != null:
		input.connect("output", _on_input)

func _process(delta: float) -> void:
	if _is_open:
		_frame_float = move_toward(_frame_float, 4, OPEN_SPEED * delta)
	else:
		_frame_float = move_toward(_frame_float, 0, CLOSE_SPEED * delta)
	
	collision_layer = 0 if _frame_float >= 2.5 else 1
	collision_mask = 0 if _frame_float >= 2.5 else 1
	
	_sprite.frame = min(int(_frame_float), 3)

func _on_input(active: bool):
	_is_open = active
