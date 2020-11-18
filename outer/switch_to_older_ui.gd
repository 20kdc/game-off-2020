extends Node

func _ready():
	if GlobalFlags.flag_get("completed_turning_point_post") and not GlobalFlags.flag_get("completed_levelC4"):
		OS.set_window_title("AscentSim 1995.8")
		get_parent().theme = preload("res://ui/v1995.tres")
		$"../VBoxContainer2/TextureRect".texture = preload("res://ui/v1995_icon.png")
