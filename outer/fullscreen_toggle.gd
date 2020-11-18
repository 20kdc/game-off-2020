extends Button

export var flag = "fullscreen"
var times = 0

func _ready():
	pressed = GlobalFlags.flag_get(flag)

func _toggled(button_pressed):
	times += 1
	if times == 9:
		$"../fidget".visible = true
	if button_pressed:
		GlobalFlags.flag_set(flag)
	else:
		GlobalFlags.flag_unset(flag)
