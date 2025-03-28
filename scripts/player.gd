extends CharacterBody3D

@export var speed: float = 10.0
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var text_2d = $Head/Sprite3D/SubViewport/Panel/Label
@onready var text_panel = $Head/Sprite3D

var camera_x_rotation: float = 0.0

var database = []  # Example list with a "word" element
	
# You can add a method to get the database if needed
func get_database() -> Array:
	return database

func set_database(word: String) -> void:
	database.append(word)
	print("Added to database:", word)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

func _physics_process(delta):
	var movement_vector = Vector3.ZERO

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_forward") and Input.is_action_pressed("jump"):
		movement_vector -= 2 * head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z * (0.05 if Input.is_action_pressed("interact") else 1)
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_left") and Input.is_action_pressed("jump"):
		movement_vector -= 2 * head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x
	if Input.is_action_pressed("movement_right") and Input.is_action_pressed("jump"):
		movement_vector += 2 * head.basis.x
		
	if Input.is_key_pressed(KEY_Y):
		var text_output = "Object Taken: " 
		for word in get_database():
				word = word.to_upper()
				text_output += word + " - "
		text_2d.text = text_output
		text_2d.visible = true
		text_panel.visible =true
		print(get_database())
	elif Input.is_key_pressed(KEY_Z):
		text_2d.visible = false
		text_panel.visible = false

	movement_vector = movement_vector.normalized()

	velocity.x = lerp(velocity.x, movement_vector.x * speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * speed, acceleration * delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	move_and_slide()
