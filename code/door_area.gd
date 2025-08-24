extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print("Entrou:", body.name)

func _on_body_exited(body):
	print("Saiu:", body.name)
