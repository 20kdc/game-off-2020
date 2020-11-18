extends Node2D

onready var cursor: MSPCCursor = get_parent()
onready var level: MSPCLevel = get_parent().get_parent()

func _process(_delta):
	if cursor.editable_target != null:
		_update_pos(cursor.editable_target, true)
	else:
		_update_pos(cursor.ordinary_target, false)

func _update_pos(target: MSPCPart, editable: bool):
	if target == null:
		visible = false
		return
	global_position = target.global_position - target.part_size
	$BRInnards.global_position = target.global_position + target.part_size
	visible = true
	if editable:
		modulate = Color(1, 1, 1)
	else:
		modulate = Color(0.6, 0.2, 0.2)
