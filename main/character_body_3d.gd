extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 5.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var direction = Vector3.ZERO

	# Récupération des inputs
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	direction = direction.normalized()

	# Déplacement
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Gravité
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Appliquer mouvement
	move_and_slide()
