extends Node2D

@export var type = "house1":
	set(value):
		type = value
		update_visuals()

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	$house1.enabled = false
	$house2.enabled = false
	$house3.enabled = false
	$house4.enabled = false
	if type == "house1":
		$house1.enabled = true
	elif type == "house2":
		$house2.enabled = true
	elif type == "house3":
		$house3.enabled = true
	elif type == "house4":
		$house4.enabled = true
