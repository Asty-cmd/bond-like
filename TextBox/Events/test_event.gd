extends EventAndDialogue



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger_event(location: Vector3):
	if called_already:
		return
	called_already = true
	var dialogue_line1 = await DialogueManager.get_next_dialogue_line(diag_text, "start")
	diag_lab.dialogue_line = dialogue_line1
	diag_lab.type_out()
	for i in range(0,10):
		var spot = get_random_direction_3d() + Vector3(0,4,0)
		spot += location
		var spawned_object = object_to_spawn.instantiate()

		get_tree().root.add_child(spawned_object)
		spawned_object.global_position = spot
		print(spawned_object.global_position)
		print(spawned_object.is_on_floor())
