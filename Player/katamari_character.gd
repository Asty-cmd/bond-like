extends RigidBody3D

var direction: Vector3 = Vector3.ZERO
var input_dir: Vector2 = Vector2.ZERO
var apply_imp: bool = false

var amount_of_metal: int = 0

signal metal_passed

@export var metal_modulo: int = 1

@export var actual_dialogue: Array[Resource]
@onready var dia_lab: DialogueLabel = $DialogueLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	if input_dir:
		direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	
	apply_central_force(direction * 10)
	direction = Vector3.ZERO

var num: int = 0


func _on_area_3d_body_entered(body: Node3D) -> void:
	
	if body is SuperBondable:
		var dChildren = body.getColAndMesh()
		for x in dChildren:
			var dupe = x.duplicate()
			if x is CollisionShape3D:
				dupe = _get_collision_shape_dube(x)
				
			#dupe.name += "{num}"
			x.reparent(self)
			
		body.queue_free()

func _get_collision_shape_dube(col_shape: CollisionShape3D) -> CollisionShape3D:
	var new_collision = CollisionShape3D.new()
	$Area3D.add_child(new_collision, true)
	new_collision.shape = col_shape.shape
	new_collision.global_position = col_shape.global_position
	new_collision.global_rotation = col_shape.global_rotation
	new_collision.scale = col_shape.scale
	#new_collision.transform.basis = col_shape.transform.basis
	return new_collision
	


	amount_of_metal += 1
	
	if amount_of_metal % metal_modulo == 0:
		metal_passed.emit()
		



func _on_metal_passed() -> void:
	var dialogue_line1 = await DialogueManager.get_next_dialogue_line(actual_dialogue[0], "start")
	dia_lab.dialogue_line = dialogue_line1
	dia_lab.type_out()
