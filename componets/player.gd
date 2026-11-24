extends Entity

@onready var _sprite: CharacterSprite = $CharacterSprite

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	# We need seperate dead zones in the x and y axies.
	# Otherwise it will be immposible to walk straight on joystick.
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up", "move_down")
	
	move(Vector2(x_direction, y_direction))
	
	if x_direction:
		_sprite.is_flipped = x_direction < 0
	
	super._process(_delta)
