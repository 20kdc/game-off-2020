extends Node

func setup(id: String):
	print("Level complete: " + id)
	GlobalFlags.flag_set("completed_" + id)
	Yank.complete()
	var next = id == ""
	for v in LevelDB.SEQUENCE:
		if next:
			print("Next level: " + v[0])
			Yank.start(v[1], v[0])
			return
		if v[0] == id:
			next = true
	Yank.start(load("res://compliance/credits.tscn"), "")
