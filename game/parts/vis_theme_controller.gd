extends Node

export var is_1995: bool = false

func _ready():
	get_parent().visible = get_parent().get_parent().get_parent().is_1995_ui == is_1995
