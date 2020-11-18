class_name MSPCWin
extends MSPCGravitySource

export var required_fraction = 0.0
var dots_arrived_here: float = 0.0

func _on_win_body_entered(body):
	if body is MSPCDot:
		body.level.dot_arrived()
		dots_arrived_here += 1
		body.start_die()

func level_start():
	dots_arrived_here = 0

func level_stop():
	dots_arrived_here = 0

func is_win_condition():
	return true

func win_condition():
	if level.dots_spawned == 0:
		return 0
	if required_fraction == 0.0:
		print("INSTANT WIN CONDITION DETECTED @ " + name)
		return 1.0
	var basis = float(dots_arrived_here) / float(level.dots_spawned)
	return min(1.0, basis / required_fraction)
