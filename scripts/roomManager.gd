extends Area2D

const LERP_RATE = 3.5

@export var player: Entity

var _room: Room
var _currentBackgroundColor: Color
var _currentTileColor: Color
var _currentSpriteColor: Color

@onready var camera: Camera2D = $Camera2D
@onready var shader: ShaderMaterial = ($PaletteLayer/PaletteRect).material

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_room()
	
	if _room != null:
		camera.global_position = player.global_position
		
		var rect = _room.shape.get_rect()
		rect.position += _room.position + position
			
		camera.limit_left = int(rect.position.x)
		camera.limit_right = int(rect.end.x)
		camera.limit_top = int(rect.position.y)
		camera.limit_bottom = int(rect.end.y)
		
		_currentBackgroundColor = _currentBackgroundColor.lerp(_room.backgroundColor, LERP_RATE * delta)
		_currentTileColor = _currentTileColor.lerp(_room.tileColor, LERP_RATE * delta)
		_currentSpriteColor = _currentSpriteColor.lerp(_room.spriteColor, LERP_RATE * delta)
		
		shader.set_shader_parameter("background_color", _currentBackgroundColor)
		shader.set_shader_parameter("tile_color", _currentTileColor)
		shader.set_shader_parameter("sprite_color", _currentSpriteColor)

func _update_room():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = player.get_target_grid_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	for collision in space_state.intersect_point(query):
		if collision.collider == self:
			var new_room = collision.collider.shape_owner_get_owner(collision.shape)
			
			if _room == null:
				_currentBackgroundColor = new_room.backgroundColor
				_currentTileColor = new_room.tileColor
				_currentSpriteColor = new_room.spriteColor
			
			_room = new_room
			return
