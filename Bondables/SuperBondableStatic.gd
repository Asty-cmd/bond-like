extends StaticBody3D
class_name SuperBondableStatic

## Bondable that stays in place — can clip into terrain. Uses StaticBody3D.

@export var metal_given: float = 1.0
@export var minimum_metal_threshhold: float = 0.0
var node3dChildren: Array[Node3D]

func _ready() -> void:
	var children = get_children()
	for x in children:
		if x is Node3D:
			node3dChildren.append(x)
	set_collision_layer_value(2, 1)

func getColAndMesh() -> Array[Node3D]:
	return node3dChildren
