class_name get_camera_view_size

# ChatGPT's function Camera2D size calculation"
static func run(camera_node: Node2D) -> Vector2:
	# Find the Camera2D inside followedNode (if it's a child)
	var cam: Camera2D = camera_node.get_node("Camera2D") if camera_node else null
	if cam == null:
		return Vector2.ZERO

	# The size of the viewport (in pixels)
	var viewport_size: Vector2 = cam.get_viewport_rect().size

	# Apply zoom (zoom is a Vector2, usually (1,1))
	var effective_size: Vector2 = viewport_size * cam.zoom
	return effective_size
