extends CharacterBody2D

@onready var anim = $AnimationPlayer

var facing_dir = "down" # default

# speed in pixels/sec
var speed = 250

func _physics_process(_delta):
	# setup direction of movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var is_right_pressed = Input.is_action_pressed("ui_right")
	var is_left_pressed = Input.is_action_pressed("ui_left")
	var is_up_pressed = Input.is_action_pressed("ui_up")
	var is_down_pressed = Input.is_action_pressed("ui_down")
	
	# stop diagonal movement by listening dwadwfor input then setting axis to zero
	if is_right_pressed || is_left_pressed:
		direction.y = 0
	elif is_up_pressed || is_down_pressed:
		direction.x = 0
	else:
		direction = Vector2.ZERO
	
	if direction != Vector2.ZERO:
		# update facing_dir
		if abs(direction.x) > abs(direction.y):
			facing_dir = "right" if direction.x > 0 else "left"
		else:
			facing_dir = "down" if direction.y > 0 else "up"
		
		anim.play("walking_" + facing_dir)
	else:
		anim.play("idle_" + facing_dir)
	
	#normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * speed)
	move_and_slide()
