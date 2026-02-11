extends EventAction
class_name DialogueEventAction

## Displays dialogue text with a moving background banner.
## Requires a DialogueLabel child node and a dialogue resource.

@export var dialogue_resource: Resource
@export var start_title: String = "start"
@export var label_position: Vector2 = Vector2(10, 712)

var moving_text_scene: PackedScene = preload("res://TextBox/MovingTextBackground.tscn")
var moving_text: Control
var _dialogue_label: DialogueLabel


func _ready() -> void:
	moving_text = moving_text_scene.instantiate()
	add_child(moving_text)
	moving_text.hide()

	# Find the DialogueLabel child
	for child in get_children():
		if child is DialogueLabel:
			_dialogue_label = child
			break


func execute(location: Vector3, event: GameEvent) -> void:
	if dialogue_resource == null or _dialogue_label == null:
		return

	var dialogue_line = await DialogueManager.get_next_dialogue_line(dialogue_resource, start_title)

	_dialogue_label.dialogue_line = dialogue_line
	_dialogue_label.position = label_position

	moving_text.show()
	moving_text.play()

	_dialogue_label.type_out()
	await _dialogue_label.finished_typing
