extends Area2D

@export var type = "house1":
	set(value):
		type = value
		update_visuals()

var house = preload("res://scenes/house.tscn")
var has_collision = false

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
	var total_bounds_size = get_total_bounds.run(self).size
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
