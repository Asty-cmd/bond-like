extends Node3D

#nodes
@export_group("Nodes")

@export var follow_node: Node3D

#Character root node.
@export var character : Node3D

#Head node.
@export var head : Node3D

@onready var camera: Camera3D = $Head/Camera3D

#Settings.
@export_group("Settings")

#Mouse settings.
@export_subgroup("Mouse settings")

#mouse sensitivity.
@export_range(1, 100, 1) var mouse_sensitivity: int = 50

#pitch clamp settings.
@export_subgroup("Clamp settings")

#max pitch in degrees.
@export var max_pitch : float = 89

#min pitch in degrees.
@export var min_pitch : float = -89

func _ready():
	Input.set_use_accumulated_input(false)

func _physics_process(delta: float) -> void:
	global_position = follow_node.global_position

func _unhandled_input(event)->void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		if event is InputEventKey:
			if event.is_action_pressed("ui_cancel"):
				get_tree().quit()
		 
		if event is InputEventMouseButton:
			if event.button_index == 1:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		return
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		return
	
	if event is InputEventMouseMotion:
		aim_look(event)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			increase_camera_distance(-0.5)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			increase_camera_distance(0.5)


#Handles aim look with the mouse.
func aim_look(event: InputEventMouseMotion)-> void:
	var motion: Vector2 = event.relative
	var degrees_per_unit: float = 0.001
	
	motion *= mouse_sensitivity
	motion *= degrees_per_unit
	
	add_yaw(motion.x)
	add_pitch(motion.y)
	clamp_pitch()


#Rotates the character around the local Y axis by a given amount (In degrees) to achieve yaw.
func add_yaw(amount)->void:
	if is_zero_approx(amount):
		return
	
	character.rotate_object_local(Vector3.DOWN, deg_to_rad(amount))
	character.orthonormalize()


#Rotates the head around the local x axis by a given amount (In degrees) to achieve pitch.
func add_pitch(amount)->void:
	if is_zero_approx(amount):
		return
	
	head.rotate_object_local(Vector3.LEFT, deg_to_rad(amount))
	head.orthonormalize()


#Clamps the pitch between min_pitch and max_pitch.
func clamp_pitch()->void:
	if head.rotation.x > deg_to_rad(min_pitch) and head.rotation.x < deg_to_rad(max_pitch):
		return
	
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(min_pitch), deg_to_rad(max_pitch))
	head.orthonormalize()


func set_camera_distance(distance: float) -> float:
	camera.position.z = distance
	return camera.position.z

func increase_camera_distance(delta: float) -> float:
	return set_camera_distance(camera.position.z + delta)

func scroll_camera_by_cursor(viewport_position: Vector2, viewport_size: Vector2, scroll_speed: float = 1.0) -> float:
	var normalized_y = viewport_position.y / viewport_size.y
	var scroll_delta = (normalized_y - 0.5) * scroll_speed
	return increase_camera_distance(scroll_delta)
