extends Area2D

@export var type = ""
var timer = Timer.new()
var current_body = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	timer.stop()
	timer.wait_time = 1.0  # segundos
	timer.autostart = true
	timer.one_shot = false  # repete
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))

func _on_body_entered(body):
	print("Entrou no detector \"", type, "\": ", body.name)
	if body.name == "Player":
		current_body = body
		body.contains[type] += 1
		timer.start()

func _on_body_exited(body):
	print("Saiu do detector \"", type, "\": ", body.name)
	timer.stop()

func _on_timeout():
	if current_body:
		current_body.contains[type] += 1
