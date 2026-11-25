extends Area2D

@export var player: Entity
@export var palette_layer: PaletteLayer
@export var camera: Camera

func _process(_delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = player.get_target_grid_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	for collision in space_state.intersect_point(query):
		if collision.collider == self:
			var room = collision.collider.shape_owner_get_owner(collision.shape)
			
			palette_layer.set_room(room)
			
			var rect = room.shape.get_rect()
			rect.position += room.position + global_position
			camera.set_rect(rect)
			
			break
