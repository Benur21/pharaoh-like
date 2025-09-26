extends Button

var house_building = preload("res://scenes/house_building.tscn")
@export var type = "house1"

func _pressed() -> void:
	if not get_tree().root.has_node("World/house_building"):
		var instance = house_building.instantiate()
		instance.type = type
		self.get_parent().add_child(instance)
	else:
		var instance =  get_tree().root.get_node("World/house_building")
		instance.type = type
