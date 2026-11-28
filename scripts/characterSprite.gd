extends Sprite2D
class_name CharacterSprite

const FRAMES_PER_SECOND = 2
const FLIP_TIME_SECONDS = 0.13

var is_flipped: bool = false
var _facing_angle: float = 0
var _inital_x_scale: float

func _ready() -> void:
	_inital_x_scale = scale.x

func _process(delta: float) -> void:
	frame = int(Time.get_ticks_msec() / 1000.0 * FRAMES_PER_SECOND) % hframes
	
	if is_flipped:
		_facing_angle = move_toward(_facing_angle, PI, delta / FLIP_TIME_SECONDS)
	else:
		_facing_angle = move_toward(_facing_angle, 0, delta / FLIP_TIME_SECONDS)
	
	scale.x = cos(_facing_angle) * _inital_x_scale
