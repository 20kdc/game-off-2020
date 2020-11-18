extends Button

export var target: PackedScene
export var param: String

func _pressed():
	Yank.start(target, param)
