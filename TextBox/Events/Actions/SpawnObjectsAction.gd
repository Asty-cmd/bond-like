extends EventAction
class_name SpawnObjectsAction

## Spawns objects at random positions around the event location.

@export var object_to_spawn: PackedScene
@export var count: int = 5
@export var radius: float = 20.0


func execute(location: Vector3, event: GameEvent) -> void:
	if object_to_spawn == null:
		return

	for i in range(count):
		var offset = _get_random_direction() * radius
		var spot = location + offset

		var spawned = object_to_spawn.instantiate()
		event.get_tree().root.add_child(spawned)
		spawned.global_position = spot


func _get_random_direction() -> Vector3:
	var x: float = randf_range(-100.0, 50.0)
	var y: float = randf_range(1.0, 1.0)
	var z: float = randf_range(-100.0, 50.0)
	return Vector3(x, y, z).normalized()
