class_name YRTextCS
extends Timer

var chars: String = ""

func _ready():
	connect("timeout", self, "_new_char")

func _new_char():
	if chars != "":
		var chr = chars.substr(0, 1)
		chars = chars.substr(1)
		get_parent().text += chr

func new_line(tx):
	get_parent().text = ""
	chars = tx

func add_line(tx):
	chars += "\n" + tx
