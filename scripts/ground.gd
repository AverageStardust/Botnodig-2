extends TileMapLayer
class_name Ground

static var instance: Ground

func _enter_tree() -> void:
	instance = self

func _exit_tree() -> void:
	instance = null

func is_slipery(location: Vector2):
	var tile_coords = local_to_map(to_local(location))
	var tile_data = get_cell_tile_data(tile_coords)
	if tile_data == null:
		return false
	else:
		return tile_data.get_custom_data("slipery")
