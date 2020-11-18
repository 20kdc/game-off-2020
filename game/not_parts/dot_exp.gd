class_name MSPCDotExp
extends MSPCDotBase

var victim: RigidBody2D
var push: Vector2

func _physics_process(delta):
	if victim != null:
		victim.linear_velocity = push
		victim.position += push
		victim = null
	else:
		push = linear_velocity
	._physics_process(delta)

func _on_dot_body_entered(body):
	if body is RigidBody2D:
		if victim == null:
			victim = body
	start_die()
