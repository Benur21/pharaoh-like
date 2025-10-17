class_name get_total_bounds

# GPT "Obter size Node2D"
static func run(node_to_search_in: Node2D, check_children_of_children: bool = true) -> Rect2:
	var rect := Rect2()
	var first := true
	
	for node in node_to_search_in.get_children():
		var children = [node]
		if node is Node2D and node.visible:
			if check_children_of_children:
				children = children + node.get_children()
			for child in children:
				if child is TileMapLayer:
					var used_rect = child.get_used_rect() # em coords de tiles
					var cell_size = child.tile_set.tile_size
					
					# tamanho em pixels do rect, antes do scale
					# converte para Vector2 para evitar o erro
					var base_pos  = Vector2(used_rect.position) * Vector2(cell_size)
					var base_size = Vector2(used_rect.size) * Vector2(cell_size)

					# aplica o scale do TileMap
					var scaled_pos  = base_pos
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
