extends Node2D

@export var camera_node: Node2D
@export var buttonsList: Array[Button]


func _physics_process(_delta):
	if camera_node:
		#print("self.position ", self.position)
		#print("followedNode.position ", followedNode.position)
		var camera_size = get_camera_view_size.run(camera_node)
		self.position.x = camera_node.position.x + (camera_size.x / 2) * 2.0/3
		self.position.y = camera_node.position.y - camera_size.y / 2
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
