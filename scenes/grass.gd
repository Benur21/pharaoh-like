extends TileMapLayer

@onready var buildings: TileMapLayer = $"../Buildings"

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if coords in buildings.get_used_cells_by_id(3):
		return true
	return false

func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if coords in buildings.get_used_cells_by_id(3):
		tile_data.set_navigation_polygon(0, null)
