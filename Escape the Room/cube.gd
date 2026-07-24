extends CharacterBody3D

var speed = 5.0

@onready var camera = $Camera3D

func _physics_process(_delta):
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("up"):
		input_dir.z += 1
	if Input.is_action_pressed("down"):
		input_dir.z -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1

	var cam_forward = -camera.global_transform.basis.z
	var cam_right = camera.global_transform.basis.x

	cam_forward.y = 0
	cam_right.y = 0

	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()

	var direction = (cam_forward * input_dir.z) + (cam_right * input_dir.x)

	if direction.length() > 0:
		direction = direction.normalized()
		rotation.y = atan2(direction.x, direction.z)

	velocity = direction * speed

	move_and_slide()
