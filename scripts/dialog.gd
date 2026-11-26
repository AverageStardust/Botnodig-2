extends StaticBody2D
class_name Dialog

const COOLDOWN_TIME = 1.2

@export var _lines: Array[String]
@export var _alt_lines: Array[String]
@export var _alt_bone_requirement: int = INT32_MAX
@export var _alt_loads_scene: PackedScene = null
@export var _gives_bone: bool = false
@export var _show_bones: bool = false

var time_since_talking = 0

@onready var _sprite = $Sprite2D
@onready var _dialog_sound = $DialogSound

func _process(delta: float) -> void:
	time_since_talking += delta

func talk_towards(location: Vector2, bones: int):
	if time_since_talking < COOLDOWN_TIME:
		return false
	
	_dialog_sound.play()
	
	if bones < _alt_bone_requirement:
		InterfaceLayer.instance.append_dialog(_lines)
	else:
		InterfaceLayer.instance.append_dialog(_alt_lines)
		
	InterfaceLayer.instance.done_dialog.connect(_after_dialog.bind(bones))
	
	if location.x > global_position.x + 2:
		_sprite.is_flipped = true
	elif location.x < global_position.x - 2:
		_sprite.is_flipped = false
	
	if _gives_bone:
		_gives_bone = false
		return true
	else:
		return false

func _after_dialog(bones: int):
	time_since_talking = 0
	
	if bones >= _alt_bone_requirement and _alt_loads_scene != null:
		get_tree().change_scene_to_packed(_alt_loads_scene)
		return
	
	if _show_bones:
		InterfaceLayer.instance.show_bones()
	
	InterfaceLayer.instance.done_dialog.disconnect(_after_dialog)
