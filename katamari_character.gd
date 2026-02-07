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
		direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	
	apply_central_force(direction * 10)
	direction = Vector3.ZERO


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is SuperBondable:
		var dChildren = body.getColAndMesh()
		for x in dChildren:
			x.reparent(self)
		body.queue_free()
	
