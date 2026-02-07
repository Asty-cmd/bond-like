extends CharacterBody3D
class_name SuperBondable

var node3dChildren: Array[Node3D]

func _ready() -> void:
	var children = get_children()
	
	for x in children:
		if x is Node3D:
			node3dChildren.append(x)
	
	set_collision_layer_value(2,1)

func getColAndMesh() -> Array[Node3D]:

	return node3dChildren
