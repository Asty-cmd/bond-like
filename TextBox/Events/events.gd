extends Node3D
class_name EventAndDialogue

@export var object_to_spawn: PackedScene = preload("res://Player/katamari_character.tscn")
@export var diag_lab: DialogueLabel
@export var diag_text: Resource

var called_already: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func trigger_event(location: Vector3):
	pass
	
func get_random_direction_3d() -> Vector3:

	var x: float = randf_range(-10.0, 10.0)
	var y: float = randf_range(1.0, 1.0)
	var z: float = randf_range(-10.0, 10.0)
	
	var random_vector: Vector3 = Vector3(x, y, z)
	
	return random_vector.normalized()
