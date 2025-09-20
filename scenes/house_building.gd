extends Node2D

# "Obter size Node2D"
func get_total_bounds() -> Rect2:
	var rect := Rect2()
	var first := true
	
	for child in get_children():
		if child is TileMapLayer:
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


func _physics_process(delta: float) -> void:
	self.position.x = get_global_mouse_position().x - get_total_bounds().size.x/2
	self.position.y = get_global_mouse_position().y - get_total_bounds().size.y/2

	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("click_right"):
		# Por path absoluto
		get_tree().root.get_node("World/Button").selected = false
		queue_free() # Remove o node da tree
		
		
