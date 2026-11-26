extends AudioStreamPlayer2D
class_name PuzzleJingle

signal complete_room

const TRIGGER_TIME = 0.9

@export var input: Node
@export var require_not_activated_by_player: bool = false

var _active: bool = false
var _trigger_progress: float = 0
var _triggered: bool = false

func _ready() -> void:
	input.connect("output", _on_input)

func _process(delta: float) -> void:
	var triggering = _active
	
	if triggering and require_not_activated_by_player:
		for puzzleInput in get_tree().get_nodes_in_group("PuzzleInputs"):
			if puzzleInput.activated_by_player:
				triggering = false
		
	if triggering:
		_trigger_progress += delta
		if _trigger_progress >= TRIGGER_TIME and not _triggered:
			_triggered = true
			play()
			complete_room.emit()
	else:
		_trigger_progress = 0

func _on_input(active: bool):
	_active = active

func reset():
	_triggered = false
