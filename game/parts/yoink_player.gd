extends MSPCPart

export var godot_bug_workaround_again: bool = false

func _physics_process(delta):
	for body in $accelerator.get_overlapping_bodies():
		if body is RigidBody2D:
			body.linear_velocity += transform.x * delta * 4000.0
