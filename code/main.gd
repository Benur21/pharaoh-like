extends Node2D

var citizen = preload("res://scenes/character.tscn")

@onready var timer := $Timer

func _ready() -> void:
	$AudioStreamPlayer.play()

var i = 0
func _on_timer_timeout() -> void:
	# create citizen
	var citizen = citizen.instantiate()
	citizen.position = Vector2(randi_range(-1900, -2100), randi_range(-900, -1100))
	self.add_child(citizen)
	
	# send them home
	var r = randi_range(0, 3)
	if r == 0:
		citizen.makepath(180, 140)
	elif r == 1:
		citizen.makepath(500, 140)
	elif r == 2:
		citizen.makepath(820, 100)
	elif r == 3:
		citizen.makepath(1000, 180)
	
	i += 1
	if i == 16:
		timer.stop()
