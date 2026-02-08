extends CharacterBody3D
class_name SuperBondable

@export var metal_given: float = 1.0

var node3dChildren: Array[Node3D]

func _ready() -> void:
	var children = get_children()
	for x in children:
		if x is Node3D:
			node3dChildren.append(x)
	set_collision_layer_value(2,1)

func getColAndMesh() -> Array[Node3D]:

	return node3dChildren

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	velocity.x = move_toward(velocity.x, 0, 5.0)
	velocity.z = move_toward(velocity.z, 0, 5.0)

	move_and_slide()
