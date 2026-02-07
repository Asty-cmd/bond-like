extends EventAndDialogue



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger_event(Vector3(1,2,1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger_event(location: Vector3):
	var dialogue_line1 = await DialogueManager.get_next_dialogue_line(diag_text, "start")
	diag_lab.dialogue_line = dialogue_line1
	diag_lab.type_out()
	
	for i in range(0,5):
		var spot = get_random_direction_3d() + Vector3(0,10,0)
		spot += location
		var spawned_object = object_to_spawn.instantiate()
		get_tree().root.add_child(spawned_object)
		spawned_object.global_position = spot
