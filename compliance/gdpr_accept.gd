extends Button

func _pressed():
	GlobalFlags.flag_set("gdpr")
	Yank.start(preload("res://outer/menu.tscn"), "")
