extends RigidBody3D

var direction: Vector3 = Vector3.ZERO
var input_dir: Vector2 = Vector2.ZERO
var apply_imp: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	if input_dir:
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#print(direction, " got here")
		apply_imp = true
	
	
func _unhandled_input(event: InputEvent) -> void:
	pass
	
		
	
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if apply_imp:
		print(direction)
		apply_central_force(direction * 10)
		direction = Vector3.ZERO
