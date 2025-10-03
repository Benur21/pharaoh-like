extends Area2D

@export var type = "house1":
	set(value):
		type = value
		update_visuals()

var house = preload("res://scenes/house.tscn")
var has_collision = false
	
# GPT "Obter size Node2D"
func get_total_bounds() -> Rect2:
	var rect := Rect2()
	var first := true
	
	for node in get_children():
		if node is Node2D and node.visible:
			for child in node.get_children():
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


func round_to_nearest_multiple(x: float, n: float) -> float:
	return int(roundf(x / n )) * n

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	$house1.visible = false
	$collision1.disabled = true
	$house2.visible = false
	$collision2.disabled = true
	$house3.visible = false
	$collision3.disabled = true
	$house4.visible = false
	$collision4.disabled = true
	get_node(type).visible = true
	if type == "house1":
		$collision1.disabled = false
	elif type == "house2":
		$collision2.disabled = false
	elif type == "house3":
		$collision3.disabled = false
	elif type == "house4":
		$collision4.disabled = false

func _physics_process(delta: float) -> void:
	const tile_size := 16*2.5;
	var total_bounds_size = get_total_bounds().size
	var mouse_position = get_global_mouse_position()
	
	self.position.x = round_to_nearest_multiple( mouse_position.x \
		- total_bounds_size.x/2, tile_size )
	self.position.y = round_to_nearest_multiple( mouse_position.y \
		- total_bounds_size.y/2, tile_size )

	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("click_right"):
		queue_free() # Remove o node da tree
	
	has_collision = get_overlapping_areas().any(func(x): return x in get_tree(). \
		get_nodes_in_group("Built Houses"))
	
	if has_collision:
		get_node(type + "/background").modulate = Color.RED
	else:
		get_node(type + "/background").modulate = Color(1, 1, 1, 1)
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not has_collision:
			# Colocar uma nova casa se bão houver colisão com outra
			var instance = house.instantiate()
			instance.type = type
			instance.position = self.position
			instance.scale = Vector2(2.5, 2.5)
			self.get_parent().add_child(instance)
