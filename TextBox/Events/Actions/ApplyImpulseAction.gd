extends EventAction
class_name ApplyImpulseAction

## Applies an upward velocity burst to all CharacterBody3D nodes within a radius,
## simulating an earthquake or shockwave effect.

@export var impulse_strength: float = 15.0
@export var radius: float = 50.0
@export var impulse_direction: Vector3 = Vector3.UP


func execute(location: Vector3, event: GameEvent) -> void:
	var bodies := _find_character_bodies_in_radius(event.get_tree(), location)
	for body in bodies:
		body.velocity += impulse_direction.normalized() * impulse_strength


func _find_character_bodies_in_radius(tree: SceneTree, origin: Vector3) -> Array[CharacterBody3D]:
	var result: Array[CharacterBody3D] = []
	_collect_bodies(tree.root, origin, result)
	return result


func _collect_bodies(node: Node, origin: Vector3, result: Array[CharacterBody3D]) -> void:
	if node is CharacterBody3D:
		var body := node as CharacterBody3D
		if body.global_position.distance_to(origin) <= radius:
			result.append(body)
	for child in node.get_children():
		_collect_bodies(child, origin, result)
