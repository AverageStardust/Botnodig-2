extends Camera2D
class_name Camera

@export var player: Entity

func _process(_delta: float) -> void:
	global_position = player.global_position

func set_rect(rect: Rect2):
	limit_left = int(rect.position.x)
	limit_right = int(rect.end.x)
	limit_top = int(rect.position.y)
	limit_bottom = int(rect.end.y)
