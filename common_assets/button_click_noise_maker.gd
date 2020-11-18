class_name ButtonClickNoiseMaker
extends Node

export var special = ""

func _process(_delta):
	get_parent().connect("button_down", self, "_button_down")
	get_parent().connect("button_up", self, "_button_up")
	get_parent().connect("toggled", self, "_toggled")
	set_process(false)

func _button_down():
	if get_parent().toggle_mode:
		return
	UISoundManager.play(special + "button_down")

func _button_up():
	if get_parent().toggle_mode:
		return
	UISoundManager.play(special + "button_up")

func _toggled(val):
	if val:
		UISoundManager.play(special + "button_down")
	else:
		UISoundManager.play(special + "button_up")
