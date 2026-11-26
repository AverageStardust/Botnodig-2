extends CanvasLayer
class_name InterfaceLayer

signal done_dialog

const FADE_SPEED = 3.5
const TEXT_SPEED = 36.0
const BONES_DISPLAY_TIME = 4.0

static var instance: InterfaceLayer

var _dialog_lines: Array[String]
var _bones_display_time: float = 0
var _has_dialog: bool = false

@onready var _dialog_rect: NinePatchRect = $DialogRect
@onready var _bone_rect: NinePatchRect = $BoneRect
@onready var _dialog_text: Label = $DialogRect/Text
@onready var _bone_count: Label = $BoneRect/Count

func _enter_tree() -> void:
	instance = self

func _exit_tree() -> void:
	instance = null

func _process(delta: float) -> void:
	
	if _has_dialog:
		_dialog_rect.modulate.a = move_toward(_dialog_rect.modulate.a, 1, delta * FADE_SPEED)
		_dialog_text.visible_ratio = move_toward(_dialog_text.visible_ratio, 1, delta * TEXT_SPEED / _dialog_text.text.length())
		
		var anything_just_pressed = Input.is_action_just_pressed("advance_dialog") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")
		if anything_just_pressed:
			if _dialog_text.visible_ratio == 1:
				_advance_dialog()
			elif _dialog_text.visible_ratio > 0.1:
				_dialog_text.visible_ratio = 1
	else:
		_dialog_rect.modulate.a = move_toward(_dialog_rect.modulate.a, 0, delta * FADE_SPEED)
	
	if _bones_display_time > 0:
		_bones_display_time -= delta
		_bone_rect.modulate.a = move_toward(_bone_rect.modulate.a, 1, delta * FADE_SPEED)
	else:
		_bone_rect.modulate.a = move_toward(_bone_rect.modulate.a, 0, delta * FADE_SPEED)

func append_dialog(lines: Array[String]):
	_dialog_lines.append_array(lines)
	_advance_dialog()

func has_dialog():
	return _has_dialog

func set_bones(bones: int):
	_bone_count.text = str(bones)
	show_bones()

func show_bones():
	_bones_display_time = BONES_DISPLAY_TIME

func _advance_dialog():
	if _dialog_lines.size() > 0:
		_dialog_text.text = _dialog_lines.pop_front()
		_dialog_text.visible_ratio = 0
		_has_dialog = true
	else:
		_has_dialog = false
		done_dialog.emit()
