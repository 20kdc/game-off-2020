extends MSPCPart

export var default_flip: bool
var flip: bool = false
var level_is_running: bool = false

func _ready():
	._ready()
	flip = default_flip

func level_start():
	level_is_running = true
	flip = default_flip

func level_stop():
	level_is_running = false
	flip = default_flip

func _process(delta):
	var g = $"vis/mid".position.x
	var dm = delta * 256
	if flip:
		g = max(-16, g - dm)
	else:
		g = min(16, g + dm)
	$"vis/mid".position.x = g

func _on_activator_body_entered(body):
	if level_is_running:
		if body is MSPCDotBase:
			if not (body.dying or body.spawner == self):
				var dot: MSPCDotBase = body.packed_scene.instance()
				body.queue_free()
				dot.position = position
				dot.spawner = self
				dot.packed_scene = body.packed_scene
				if flip:
					dot.linear_velocity = transform.x * -800
				else:
					dot.linear_velocity = transform.x * 800
				get_parent().add_child(dot)
				flip = not flip
