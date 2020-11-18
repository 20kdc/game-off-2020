extends Node

export var progress: float = 0.0

func _process(delta):
	var vp = get_viewport()
	if vp == null:
		return
	$spr.position = (vp.size - lerp(Vector2(1280, 720), Vector2(1920, 720), progress))
