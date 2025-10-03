extends Node2D

@export var type = "house1":
	set(value):
		type = value
		update_visuals()

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	$house1.enabled = false
	$collision1.disabled = true
	$house2.enabled = false
	$collision2.disabled = true
	$house3.enabled = false
	$collision3.disabled = true
	$house4.enabled = false
	$collision4.disabled = true
	if type == "house1":
		$house1.enabled = true
		$collision1.disabled = false
	elif type == "house2":
		$house2.enabled = true
		$collision2.disabled = false
	elif type == "house3":
		$house3.enabled = true
		$collision3.disabled = false
	elif type == "house4":
		$house4.enabled = true
		$collision4.disabled = false
