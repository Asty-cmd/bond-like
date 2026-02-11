extends EventAction
class_name SwitchCameraAction

## Switches the active camera to a target camera for a duration, then reverts.
## If revert_after_seconds <= 0, the camera stays switched permanently.

@export var target_camera: Camera3D
@export var revert_after_seconds: float = 0.0


func execute(location: Vector3, event: GameEvent) -> void:
	if target_camera == null:
		return

	var previous_camera := event.get_viewport().get_camera_3d()
	target_camera.make_current()

	if revert_after_seconds > 0.0 and previous_camera != null:
		await event.get_tree().create_timer(revert_after_seconds).timeout
		if is_instance_valid(previous_camera):
			previous_camera.make_current()
