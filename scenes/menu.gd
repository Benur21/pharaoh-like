extends Node2D

@export var followedNode: Node2D
@export var buttonsList: Array[Button]

# ChatGPT's function Camera2D size calculation"
func get_camera_view_size() -> Vector2:
	# Find the Camera2D inside followedNode (if it's a child)
	var cam: Camera2D = followedNode.get_node("Camera2D") if followedNode else null
	if cam == null:
		return Vector2.ZERO

	# The size of the viewport (in pixels)
	var viewport_size: Vector2 = cam.get_viewport_rect().size

	# Apply zoom (zoom is a Vector2, usually (1,1))
	var effective_size: Vector2 = viewport_size * cam.zoom
	return effective_size

func _physics_process(_delta):
	if followedNode:
		#print("self.position ", self.position)
		#print("followedNode.position ", followedNode.position)
		var camera_size = get_camera_view_size()
		self.position.x = followedNode.position.x + (camera_size.x / 2) * 2.0/3
		self.position.y = followedNode.position.y - camera_size.y / 2
		self.scale.x = (1.0 / 10 * 1.0 / 16) * (camera_size.x / 2) * 1.0/3
		self.scale.y = (1.0 / 10 * 1.0 / 16) * camera_size.y
	
		for btn_i in range(len(buttonsList)):
			var btn: Button = buttonsList[btn_i]
			btn.z_index = 4
			#print(btn_i)
			btn.position.x = self.position.x + 16
			var sumOfAllButtonsHeightUntilCurrent = 0
			for btn2 in buttonsList.slice(0, btn_i):
				#print(btn2)
				sumOfAllButtonsHeightUntilCurrent += btn2.get_rect().size.y
			
			btn.position.y = self.position.y + \
				sumOfAllButtonsHeightUntilCurrent + 10 * (btn_i + 1) * 2
			#print(sumOfAllButtonsHeightUntilCurrent)
			#print(btn.position.x)
			#print(btn.position.y)
			#print()
			
			btn.scale.x = 0.5
			btn.scale.y = 0.5

			
