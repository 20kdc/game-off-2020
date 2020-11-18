extends MSPCPart

export var power = 500.0

func _physics_process(delta):
	for body in $accelerator.get_overlapping_bodies():
		if body is MSPCDotBase:
			if not (body.dying or body.spawner == self):
				body.dying = true
				body.queue_free()
				var new: MSPCDotBase = body.packed_scene.instance()
				new.position = position
				new.linear_velocity = transform.x * power
				new.packed_scene = body.packed_scene
				new.spawner = self
				get_parent().add_child(new)
