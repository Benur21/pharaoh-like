extends Button

var house_building = preload("res://scenes/house_building.tscn")
@export var selected = false

func _pressed() -> void:
	if not selected:
		var instance = house_building.instantiate()
		self.get_parent().add_child(instance)
		selected = true
