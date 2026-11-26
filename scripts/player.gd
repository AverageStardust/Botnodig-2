extends Entity
class_name Player

var _bones: int = 0

@onready var _sprite: CharacterSprite = $CharacterSprite

func _process(_delta: float) -> void:	
	if not InterfaceLayer.instance.has_dialog():
		# We need seperate dead zones in the x and y axies.
		# Otherwise it will be immposible to walk straight on joystick.
		var x_direction = Input.get_axis("move_left", "move_right")
		var y_direction = Input.get_axis("move_up", "move_down")
		
		move(Vector2(x_direction, y_direction))
		
		if x_direction:
			_sprite.is_flipped = x_direction < 0
	
	super._process(_delta)

func collect_bone(slimy = false):
	_bones += 1
	InterfaceLayer.instance.set_bones(_bones)
	
	if not slimy:
		InterfaceLayer.instance.append_dialog(["[You found an old bone]"])
	else:
		InterfaceLayer.instance.append_dialog(["[You found a slimy bone]"])

func _on_ran_into(node: Node2D):
	if node is Dialog:
		var gives_bone = node.talk_towards(global_position, _bones)
		
		if gives_bone:
			InterfaceLayer.instance.done_dialog.connect(_collect_bone_after_dialog)

func _collect_bone_after_dialog():
	collect_bone(true)
	InterfaceLayer.instance.done_dialog.disconnect(_collect_bone_after_dialog)
