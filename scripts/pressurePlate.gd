extends Area2D

signal output(active: bool)

var _active = false
var activated_by_player = false

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _press_sound: AudioStreamPlayer2D = $PressSound
@onready var _release_sound: AudioStreamPlayer2D = $ReleaseSound

func _process(_delta: float) -> void:
	activated_by_player = false
	
	for body in get_overlapping_bodies():
		if body is Player:
			activated_by_player = true
	
	if _active != has_overlapping_bodies():
		_active = has_overlapping_bodies()
		
		_sprite.frame = 1 if _active else 0
		
		if _active:
			_press_sound.play()
		else:
			_release_sound.play()
		
		output.emit(_active)
