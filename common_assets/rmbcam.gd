class_name MSPCRMBCam
extends KinematicBody2D

var waiting: Vector2 = Vector2()
onready var actual_camera = $Camera2D

var process_two = false

func _process(delta):
	if not process_two:
		process_two = true
	else:
		actual_camera.smoothing_enabled = true
	if delta == 0.0:
		# blackscreen would happen if this propagated
		#print("blackscreen fix triggered, delta: " + str(delta))
		return
	var move = waiting / delta
	waiting = Vector2()
	move_and_slide(move)

func _input(event):
	if event is InputEventMouseMotion:
		if event.button_mask & BUTTON_MASK_RIGHT:
			waiting -= event.relative * 1.1
