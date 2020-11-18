class_name RigidSender
extends Node

func _ready():
	get_parent().connect("body_entered", self, "_body_entered")

func _body_entered(body):
	if body is StaticReceiver2D:
		body.emit_signal("body_entered", get_parent())
