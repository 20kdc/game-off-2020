extends Node2D

export var rps = 1.0

func _process(delta):
	rotation_degrees += delta * 360 * rps
