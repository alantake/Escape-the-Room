extends Camera3D

@export var sensitivity = 0.2
@export var distance = 4.0
@export var height = 2.5

var rotation_x = -15.0
var yaw = 0.0

@onready var player = get_parent()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity
		rotation_x -= event.relative.y * sensitivity
		
		rotation_x = clamp(rotation_x, -60, 40)

func _process(_delta):
	var offset = Vector3(
		0,
		0,
		distance
	)

	offset = offset.rotated(Vector3.RIGHT, deg_to_rad(rotation_x))
	offset = offset.rotated(Vector3.UP, deg_to_rad(yaw))

	global_position = player.global_position + Vector3(0, height, 0) + offset

	look_at(player.global_position + Vector3(0, 1, 0), Vector3.UP)
