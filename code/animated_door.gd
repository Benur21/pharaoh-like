#extends Area2D
#
##@onready var anim = $AnimationPlayer
##@onready var solid = $StaticBody2D
#
#
##func _ready():
	##connect("body_entered", Callable(self, "_on_body_entered"))
##
##func _on_body_entered(body):
	##if body.name == "Player":   # podes trocar pelo nome do teu nó do jogador
		##anim.play("open")
		##solid.set_deferred("disabled", true)  # desativa colisão da porta
#
#func _ready():
	#connect("body_entered", Callable(self, "_on_body_entered"))
#
#func _on_body_entered(body):
	#print("Entrou:", body.name)
#
#func _on_Area2D_body_entered(body):
	#print("Entrou:", body.name)

extends Node2D

@onready var static_body = $StaticBody2D
@onready var animation_player = $StaticBody2D/AnimationPlayer
@onready var area = $Area2D
@onready var static_collision = $StaticBody2D/CollisionShape2D
@onready var area_collision = $Area2D/CollisionShape2D

func _ready():
	if visible:
		area.body_entered.connect(_on_body_entered)
		area.body_exited.connect(_on_body_exited)
		animation_player.play("closed")
	else:
		static_collision.disabled = true
		area_collision.disabled = true

func _on_body_entered(body):
	if visible:
		print("Entrou:", body.name)
		animation_player.play("opening")

func _on_body_exited(body):
	if visible:
		print("Saiu:", body.name)
		animation_player.play("closing")
