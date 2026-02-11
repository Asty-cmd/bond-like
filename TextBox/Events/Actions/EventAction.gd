extends Node
class_name EventAction

## Base class for composable event actions.
## Override execute() in subclasses to define behavior.
## Actions are children of a GameEvent and run in tree order.


func execute(location: Vector3, event: GameEvent) -> void:
	pass
