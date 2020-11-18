extends Area2D

var velocity: Vector2

func _ready():
	velocity = (-global_transform.y) * 25.0

func _physics_process(delta):
	global_position += velocity * delta

func _on_Node2D_body_entered(body):
	if body is MSPCDotBase:
		if not body.dying:
			velocity += body.linear_velocity
			body.start_die()
