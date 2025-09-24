extends Node2D

@export var type = "house1"
@export var selected = false

# GPT "Obter size Node2D"
func get_total_bounds() -> Rect2:
	var rect := Rect2()
	var first := true
	
	for child in get_children():
		if child is TileMapLayer and child.enabled:
			var used_rect = child.get_used_rect() # em coords de tiles
			var cell_size = child.tile_set.tile_size
			
			# tamanho em pixels do rect, antes do scale
			# converte para Vector2 para evitar o erro
			var base_pos  = Vector2(used_rect.position) * Vector2(cell_size)
			var base_size = Vector2(used_rect.size) * Vector2(cell_size)

			# aplica o scale do TileMap
			var scaled_pos  = base_pos * child.scale
			var scaled_size = base_size * child.scale
			
			var child_rect = Rect2(scaled_pos, scaled_size)
			
			# transforma para coords globais, caso o TileMap esteja movido
			child_rect.position = child.to_global(child_rect.position)
			
			if first:
				rect = child_rect
				first = false
			else:
				rect = rect.merge(child_rect)
	
	return rect


func round_to_nearest_multiple(x: float, n: float) -> float:
	return int(roundf(x / n )) * n

func _ready() -> void:
	$background1.enabled = false
	$house1.enabled = false
	$background2.enabled = false
	$house2.enabled = false
	if type == "house1":
		$background1.enabled = true
		$house1.enabled = true
	elif type == "house2":
		$background2.enabled = true
		$house2.enabled = true
		
func _physics_process(delta: float) -> void:
	const tile_size := 16*2.5;
	self.position.x = round_to_nearest_multiple( get_global_mouse_position().x \
		- get_total_bounds().size.x/2, tile_size )
	self.position.y = round_to_nearest_multiple( get_global_mouse_position().y \
		- get_total_bounds().size.y/2, tile_size )

	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("click_right"):
		selected = false
		queue_free() # Remove o node da tree
		
		
