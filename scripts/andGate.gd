extends Node

signal output(active: bool)

@export var inputs: Array[Node]

var _states: Array[bool]

func _ready() -> void:
	_states.resize(inputs.size())
	
	for i in range(inputs.size()):
		inputs[i].output.connect(_on_input.bind(i))
		_states[i] = false

func _on_input(active: bool, index: int):
	_states[index] = active
	
	var outputActive: bool = true 
	for i in range(inputs.size()):
		outputActive = outputActive and _states[i]
	
	output.emit(outputActive)
