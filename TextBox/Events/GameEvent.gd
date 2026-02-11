extends Node3D
class_name GameEvent

## Container node that orchestrates child EventAction nodes.
## Add EventAction children in the editor to compose event behavior.
## Call trigger_event(location) to execute all actions in order.

@export var cleanup_delay: float = 5.0

var called_already: bool = false

signal event_finished


func trigger_event(location: Vector3) -> void:
	if called_already:
		return
	called_already = true

	for child in get_children():
		if child is EventAction:
			await child.execute(location, self)

	event_finished.emit()
	await get_tree().create_timer(cleanup_delay).timeout
	queue_free()
