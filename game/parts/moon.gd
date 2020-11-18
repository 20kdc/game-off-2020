class_name MSPCMoon
extends MSPCGravitySource

# editor panel needs to be coerced to show up
export var dummy_godot_bug_workaround: bool = false

func _on_StaticBody2D_body_entered(body):
	if body is MSPCDot:
		body.start_die()
