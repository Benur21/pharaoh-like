extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var wood = $Wood
@onready var wood_count = $Wood_count
@export var contains := {"wood": 0, "gold": 0}

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var facing_dir = "down" # default

# speed in pixels/sec
var speed = 250

func makepath() -> void:
	nav_agent.target_position = Vector2(randi_range(-100, 100), randi_range(-100, 100))

func move():
	# setup direction of movement
	var direction = to_local(nav_agent.get_next_path_position())
	
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

func _physics_process(_delta):
	move()
	
	if (contains.wood && contains.wood > 0):
		wood.visible = true
		wood_count.text = str(contains.wood)
	else:
		wood.visible = false
		wood_count.text = ""
