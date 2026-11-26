extends CollisionShape2D
class_name Room

@export var backgroundColor: Color = Color(0, 0, 0, 1)
@export var tileColor: Color = Color(0.5, 0.5, 0.5, 1)
@export var spriteColor: Color = Color(1, 1,1 , 1)

var is_complete = false

func _ready() -> void:
	for node in get_children():
		if node is PuzzleJingle:
			node.complete_room.connect(complete)

func reset():
	for node in get_children():
		if node.is_in_group("PuzzleResets"):
			node.reset()

func complete():
	is_complete = true

	for node in get_children():
		if node.is_in_group("PuzzleLocks"):
			node.lock()
