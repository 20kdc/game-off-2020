extends MSPCPart

func level_start():
	enable()

func level_stop():
	enable()

func enable():
	$gate.collision_layer = 1
	$gate.collision_mask = 1
	$vis.visible = true

func disable():
	$gate.collision_layer = 0
	$gate.collision_mask = 0
	$vis.visible = false
