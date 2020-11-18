class_name TurntablePart
extends TurntableBase

func _ready():
	var tst = self
	while tst != null:
		if tst is MSPCLevel:
			if tst.has_sun:
				offset = -90
				get_parent().modulate = Color(0.9, 0.9, 0.8)
			return
		else:
			tst = tst.get_parent()

