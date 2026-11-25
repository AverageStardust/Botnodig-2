extends CharacterBody2D
class_name Entity

const GRID_SIZE = 8
const MAX_SPEED = 36.0
const ACCELERATION = 12.0

var _grid_position: Vector2
var _future_grid_position: Vector2
var _is_moving_horizontal: bool = false
var _is_moving_vertical: bool = false
var _speed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_grid_position = (position / GRID_SIZE).round() * GRID_SIZE
	_future_grid_position = _grid_position
	position = _grid_position

func _process(delta: float) -> void:
	if position == _future_grid_position:
		_speed = 0
	else:
		_speed = lerp(_speed, MAX_SPEED, delta * ACCELERATION)
		
	position = position.move_toward(_future_grid_position, delta * _speed)
	
	if position.x == _future_grid_position.x:
		_grid_position.x = _future_grid_position.x
		_is_moving_horizontal = false
	
	if position.y == _future_grid_position.y:
		_grid_position.y = _future_grid_position.y
		_is_moving_vertical = false

func move(direction: Vector2) -> bool:
	var success = true
	
	if direction.x != 0 and not _is_moving_horizontal:
		var offset = Vector2(sign(direction.x) * GRID_SIZE, 0)
		
		if _check_grid(offset):
			_is_moving_horizontal = true
		else:
			success = false
	
	if direction.y != 0 and not _is_moving_vertical:
		var offset = Vector2(0, sign(direction.y) * GRID_SIZE)
		
		if _check_grid(offset):
			_is_moving_vertical = true
		else:
			success = false
	
	return success

func _check_grid(offset: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	
	# If moving, check both current and future position.
	if _future_grid_position != _grid_position:
		# Don't move if there is anything in the way.
		query.position = get_current_grid_position() + offset
		if space_state.intersect_point(query, 1).size() > 0:
			return false
		
		# Don't move if there will be anything in the way.
		query.position = get_target_grid_position() + offset
		if space_state.intersect_point(query, 1).size() > 0:
			return false
	else:
		query.position = get_current_grid_position() + offset
		var blocking_bodies = space_state.intersect_point(query, 2)
		
		# Don't move if there are multible entities, or any non-entities in the way.
		if blocking_bodies.size() > 1:
			return false
		elif blocking_bodies.size() == 1:
			var body = blocking_bodies[0].collider
			if body is Entity:
				# Try to push one entity if present.
				if body.move(offset):
					body._speed = _speed
				else:
					return false
			else:
				return false
	
	_future_grid_position += offset
	return true

func get_current_grid_position():
	return _grid_position + Vector2(GRID_SIZE, GRID_SIZE) / 2 

func get_target_grid_position():
	return _future_grid_position + Vector2(GRID_SIZE, GRID_SIZE) / 2 
