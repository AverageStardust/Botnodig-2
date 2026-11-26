extends Entity
class_name Crate

var _original_position

func _ready() -> void:
	super._ready()
	_original_position = global_position

func reset():
	global_position = _original_position
	_grid_position = _original_position
	_future_grid_position = _original_position

func lock():
	_moveable = false
