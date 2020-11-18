class_name MSPCDot
extends MSPCDotBase

func _start_die_internal():
	level.dot_died()
	._start_die_internal()
