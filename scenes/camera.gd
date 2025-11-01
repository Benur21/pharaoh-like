extends Node2D

# speed in pixels/sec
var speed = 25

func move():
	# setup direction of keyboard movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var is_right_pressed = Input.is_action_pressed("ui_right")
	var is_left_pressed = Input.is_action_pressed("ui_left")
	var is_up_pressed = Input.is_action_pressed("ui_up")
	var is_down_pressed = Input.is_action_pressed("ui_down")
	
	var camera_size = get_camera_view_size.run(self)
	
	# move on borders
	var mouse_pos = get_viewport().get_mouse_position()
	if mouse_pos.x < 15.0:
		direction.x = -1
	elif mouse_pos.x > (camera_size.x - 16.0):
		direction.x = 1
	if mouse_pos.y < 15.0:
		direction.y = -1
	elif mouse_pos.y > (camera_size.y - 16.0):
		direction.y = 1
	
	# setup the actual movement
	var velocity = (direction * speed)
	
	# delimit movement on borders
	var world_rect = get_total_bounds.run(get_tree().root.get_node("World"), false)
	var allowed_rect = world_rect
	var menu_size = get_total_bounds.run(get_tree().root.get_node("World/Menu"), false).size
	allowed_rect.position += camera_size / 2
	allowed_rect.size -= camera_size
	allowed_rect.size.x += menu_size.x
	if (allowed_rect.has_point(position + Vector2(velocity.x, 0))):
		position.x += velocity.x # Move camera
	if (allowed_rect.has_point(position + Vector2(0, velocity.y))):
		position.y += velocity.y # Move camera
	
	if position.x < allowed_rect.position.x:
		position.x = allowed_rect.position.x
	if position.y < allowed_rect.position.y:
		position.y = allowed_rect.position.y
	if position.x > allowed_rect.position.x + allowed_rect.size.x:
		position.x = allowed_rect.position.x + allowed_rect.size.x
	if position.y > allowed_rect.position.y + allowed_rect.size.y:
		position.y = allowed_rect.position.y + allowed_rect.size.y
	
	
func _physics_process(_delta):
	move()
	
