extends Container

func _ready():
	var available = true
	var dev = GlobalFlags.flag_get("developer")
	var remaining_in_row = 0
	for v in LevelDB.SEQUENCE:
		if v[2] != null:
			var btn = Button.new()
			btn.add_child(ButtonClickNoiseMaker.new())
			btn.text = v[2]
			btn.rect_min_size = btn.get_minimum_size()
			if not available:
				if dev:
					btn.text += "*"
				else:
					btn.disabled = true
					btn.text = "..."
			btn.connect("pressed", Yank, "start", [v[1], v[0]])
			if v[3] != null:
				while remaining_in_row > 0:
					add_child(Control.new())
					remaining_in_row -= 1
				remaining_in_row = 4
				var l = Label.new()
				l.text = v[3]
				if not available:
					l.text = "..."
				add_child(l)
			add_child(btn)
			remaining_in_row -= 1
		available = GlobalFlags.flag_get("completed_" + v[0])
	pass
