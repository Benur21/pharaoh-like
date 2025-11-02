extends Node2D

var citizen = preload("res://scenes/character.tscn")

@onready var timer := $Timer

func _ready() -> void:
	$AudioStreamPlayer.play()

var i = 0
func _on_timer_timeout() -> void:
	var citizen = citizen.instantiate()
	
	citizen.position = Vector2(randi_range(-1900, -2100), randi_range(-900, -1100))
	
	self.add_child(citizen)
	
	citizen.makepath()
	i += 1
	if i == 10:
		timer.stop()
