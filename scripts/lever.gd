extends Area2D
class_name Lever

signal output(active: bool)

const ANIMATION_SPEED = 6.0

var _active = false
var _locked = false
var _wasBeingTouched = false
var _progress: float = 0
var activated_by_player = false

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _on_sound: AudioStreamPlayer2D = $OnSound
@onready var _off_sound: AudioStreamPlayer2D = $OffSound

func _process(delta: float) -> void:	
	if has_overlapping_bodies() and not _wasBeingTouched and not _locked:
		_active = not _active
		
		if _active:
			for body in get_overlapping_bodies():
				if body is Player:
					activated_by_player = true
		else:
			activated_by_player = false
		
		if _active:
			_on_sound.play()
		else:
			_off_sound.play()
		
		output.emit(_active)
	
	if _active:
		_progress = move_toward(_progress, 3.0, delta * ANIMATION_SPEED)
	else:
		_progress = move_toward(_progress, 0.0, delta * ANIMATION_SPEED)
	
	_sprite.frame = min(int(_progress), 2)
	
	_wasBeingTouched = has_overlapping_bodies()

func reset():
	if _active:
		_off_sound.play()
	
	_active = false

func lock():
	_locked = true
