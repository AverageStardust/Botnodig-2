extends CanvasLayer
class_name PaletteLayer

const LERP_RATE = 3.5

var _room: Room
var _currentBackgroundColor: Color
var _currentTileColor: Color
var _currentSpriteColor: Color

@onready var shader: ShaderMaterial = $ColorRect.material

func _ready() -> void:
	visible = true

func _process(delta: float) -> void:
	if _room != null:
		_currentBackgroundColor = _currentBackgroundColor.lerp(_room.backgroundColor, LERP_RATE * delta)
		_currentTileColor = _currentTileColor.lerp(_room.tileColor, LERP_RATE * delta)
		_currentSpriteColor = _currentSpriteColor.lerp(_room.spriteColor, LERP_RATE * delta)
		
		shader.set_shader_parameter("background_color", _currentBackgroundColor)
		shader.set_shader_parameter("tile_color", _currentTileColor)
		shader.set_shader_parameter("sprite_color", _currentSpriteColor)

func set_room(room: Room):
	if _room == null:
		_currentBackgroundColor = room.backgroundColor
		_currentTileColor = room.tileColor
		_currentSpriteColor = room.spriteColor
	
	_room = room
