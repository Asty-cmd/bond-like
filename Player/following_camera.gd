extends Camera3D

@export var follows_player: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follows_player != null:
		global_position = follows_player.global_position + Vector3(0,12,12) #* ((follows_player.amount_of_metal*+4))
