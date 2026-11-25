extends Area2D

func _process(_delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is Player:
			body.collect_bone()
			queue_free()
