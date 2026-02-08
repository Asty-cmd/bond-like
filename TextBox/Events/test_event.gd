extends EventAndDialogue

var moving_text_load = preload("res://TextBox/MovingTextBackground.tscn")
var moving_text: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moving_text = moving_text_load.instantiate()
	add_child(moving_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func text_over():
	await get_tree().create_timer(5.0).timeout
	queue_free()

func trigger_event(location: Vector3):
	if called_already:
		return
	called_already = true
	var dialogue_line1 = await DialogueManager.get_next_dialogue_line(diag_text, "start")
	
	diag_lab.dialogue_line = dialogue_line1
	moving_text.show()
	moving_text.play()
	diag_lab.type_out()
	diag_lab.finished_typing.connect(text_over)
	for i in range(0,5):
		var spot = get_random_direction_3d() * 2 + Vector3(0,4,0)
		spot += location
		var spawned_object = object_to_spawn.instantiate()

		get_tree().root.add_child(spawned_object)
		spawned_object.global_position = spot
