# This exists so that the dependency graph works properly
# Level needs to detect parts, and needs to have access to their
#  basic functions, but parts need a Level reference
# So to solve it, I present...
class_name MSPCPartBase
extends Area2D

export var editable: bool
export var part_size: Vector2 = Vector2(48, 48)

signal dropped()

func save_savedata():
	return str(position.x) + ";" + str(position.y) + ";" + str(rotation)

func load_savedata(dat):
	position = Vector2(float(dat[1]), float(dat[2]))
	rotation = float(dat[3])

func level_start():
	pass

func level_stop():
	pass

func is_win_condition():
	return false

func win_condition():
	return 0.0
