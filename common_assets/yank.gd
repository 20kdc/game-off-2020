extends Node

var state = 0
var packed_scene = null
var data = null
var start_time = 0.0

func start(ps: PackedScene, ydata):
	if state != 0:
		push_warning("attempted to yank while already yanking")
		return
	state = 1
	packed_scene = ps
	data = ydata
	Engine.time_scale = 1.0
	Fader.target_state = 1.0
	Fader.connect("reached_target", self, "_fader_reached_state_1", [], CONNECT_ONESHOT)

func _fader_reached_state_1():
	# just in case
	Engine.time_scale = 1.0
	start_time = OS.get_ticks_msec()
	get_tree().change_scene_to(packed_scene)
	state = 2

func _process(_delta):
	if state == 2:
		# do this *first* in case of early complete
		state = 3
		var dat = data
		data = null
		var scn = get_tree().current_scene
		if scn.has_method("setup"):
			scn.setup(dat)
		else:
			print("-- no setup function --")
			complete()

func complete():
	print("Yank took " + str(OS.get_ticks_msec() - start_time) + "ms")
	if state != 3:
		push_warning("attempted to complete yank in wrong state")
	state = 0
	Fader.target_state = 0.0
