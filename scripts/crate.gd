extends Entity
class_name Crate

@onready var _original_position = global_position

func reset():
	global_position = _original_position
