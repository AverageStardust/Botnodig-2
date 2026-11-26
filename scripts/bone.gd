extends Area2D
class_name Bone

signal complete_room

const FLOAT_SPEED = 32
const FADE_SPEED = 1.25

var _collected = false

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _pickup_sound: AudioStreamPlayer2D = $PickupSound

func _process(_delta: float) -> void:
	if _collected:
		position.y -= _delta * FLOAT_SPEED
		_sprite.modulate.a -= _delta * FADE_SPEED
		
		if _sprite.modulate.a <= 0:
			queue_free()
	else:
		for body in get_overlapping_bodies():
			if body is Player:
				body.collect_bone()
				_collected = true
				complete_room.emit()
				
				_pickup_sound.play()
