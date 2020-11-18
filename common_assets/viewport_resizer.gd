extends ViewportContainer

onready var viewport = $Viewport

var mouse_down_on_viewport: bool = false

func _ready():
	viewport.size = rect_size

func _notification(what):
	if what == NOTIFICATION_RESIZED:
		viewport.size = rect_size

func _gui_input(event):
	if event is InputEventMouseButton:
		#print("checkpoint " + str(event.button_index))
		if event.button_index == 1:
			mouse_down_on_viewport = event.pressed
