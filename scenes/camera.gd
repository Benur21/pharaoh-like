extends Node2D

# speed in pixels/sec
var speed = 25

func move():
	# setup direction of movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var is_right_pressed = Input.is_action_pressed("ui_right")
	var is_left_pressed = Input.is_action_pressed("ui_left")
	var is_up_pressed = Input.is_action_pressed("ui_up")
	var is_down_pressed = Input.is_action_pressed("ui_down")
	
	# setup the actual movement
	var velocity = (direction * speed)
	
	var world_rect = get_total_bounds.run(get_tree().root.get_node("World"), false)
	var allowed_rect = world_rect
	var camera_size = get_camera_view_size.run(self)
	var menu_size = get_total_bounds.run(get_tree().root.get_node("World/Menu"), false).size
	allowed_rect.position += camera_size / 2
	allowed_rect.size -= camera_size
	allowed_rect.size.x += menu_size.x
	if (allowed_rect.has_point(position + Vector2(velocity.x, 0))):
		position.x += velocity.x # Move camera
	if (allowed_rect.has_point(position + Vector2(0, velocity.y))):
		position.y += velocity.y # Move camera
	
	
func _physics_process(_delta):
	move()
	
