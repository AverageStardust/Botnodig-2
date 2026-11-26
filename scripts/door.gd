extends StaticBody2D
class_name Door

@export var input: Node

const OPEN_SPEED = 4.5
const CLOSE_SPEED = 7.0

var _is_open: bool = false
var _progress: float = 0

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _open_sound: AudioStreamPlayer2D = $OpenSound
@onready var _close_sound: AudioStreamPlayer2D = $CloseSound

func _ready() -> void:
	if input != null:
		input.connect("output", _on_input)

func _process(delta: float) -> void:
	var old_progress = _progress
	if _is_open:
		_progress = move_toward(_progress, 4, OPEN_SPEED * delta)
	else:
		_progress = move_toward(_progress, 0, CLOSE_SPEED * delta)
	
	_sprite.frame = min(int(_progress), 3)
	
	if old_progress < 0.5 && _progress > 0.5:
		_open_sound.play()
	elif old_progress > 2.0 && _progress < 2.0:
		_close_sound.play()
	
	collision_layer = 0 if _progress >= 2.5 else 1
	collision_mask = 0 if _progress >= 2.5 else 1

func _on_input(active: bool):
	_is_open = active
