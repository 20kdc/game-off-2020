extends Control

var level_id: String
var level: MSPCLevel

onready var win_screen = $WinScreen
onready var rtm_screen = $RTMScreen
onready var video_call = find_node("VideoCall")
onready var progress_bar_1 = find_node("ProgressBar")
onready var win_screen_continue = find_node("WinScreenContinue")
onready var rsb = find_node("RunStopButton")
onready var cheats = find_node("Cheats")
onready var hint_giver_text = find_node("HintGiverText")
onready var hint_advance = find_node("HintAdvance")
onready var level_gimmick_text = find_node("LevelGimmickLabel")
onready var time_slider = find_node("TimeSlider")
onready var viewport_container = $ViewportContainer
onready var camera: Node2D = $"ViewportContainer/Viewport/rmbcam"

func setup(map: String):
	# load
	level = load("res://levels/" + map + ".tscn").instance()
	level_id = map
	find_node("Viewport").add_child(level)
	# connect signals
	level.connect("level_started", self, "_level_started")
	level.connect("level_stopped", self, "_level_stopped")
	level.connect("were_going_meta", video_call, "setup")
	level.connect("level_hint", self, "_update_hint")
	level.connect("level_wants_focus_on", self, "_focus_on")
	# inject
	level.add_child(preload("injected/cursor.tscn").instance())
	camera.position = level.camera_start.position
	# setup UI
	win_screen.visible = false
	rtm_screen.visible = false
	video_call.visible = false
	cheats.visible = GlobalFlags.flag_get("developer")
	time_slider.editable = not level.no_mischief
	find_node("LevelNameLabel").text = level.english_name
	if level.is_1995_ui:
		theme = preload("res://ui/v1995.tres")
	_update_hint()
	# done
	Yank.complete()

func _update_hint():
	hint_giver_text.percent_visible = 0
	hint_giver_text.text = "Incoming from: " + level.english_hint_giver + "\n" + level.english_hint

func _process(delta):
	hint_advance.disabled = not level.hint_advancable
	rsb.disabled = level.run_stop_locked
	hint_giver_text.percent_visible += delta / (level.hint_time * Engine.time_scale)
	level_gimmick_text.text = level.english_level_gimmick
	level.mouse_left_down = viewport_container.mouse_down_on_viewport
	var fraction = level.calc_win_fraction()
	if level.running:
		if not win_screen.visible:
			if fraction >= 1.0:
				_save_and_complete()
				if not level.override_win_ack():
					win_screen.visible = true
				else:
					Yank.start(load("res://outer/interlevel_router.tscn"), level_id)
	progress_bar_1.value = fraction * 100

func _save_and_complete():
	GlobalFlags.core.set_value("solutions", level_id, level.save_savedata())
	GlobalFlags.flag_set_nosave("completed_" + level_id)
	GlobalFlags.save_flags()

func _on_Button_toggled(button_pressed):
	if button_pressed:
		var check = level.get_editable_parts_in_noplace()
		if len(check) == 0:
			level.level_start()
		else:
			_focus_on(check[0])
			if level_id == "tutorial":
				level.english_hint_giver = "Joanna Ipcrus"
				level.english_hint = "The blocker can't be put there, unfortunately."
				level.hint_time = 4
			elif level.is_turning_point:
				if level.turning_point_disable_spawner:
					level.english_hint = "Ha! There's nothing to launch. Didn't you know that already, though?"
				else:
					level.english_hint = "The launch engineers tell me it's not possible to move the blocker into that position."
				level.hint_time = 4
			else:
				level.english_hint_giver = "SYSTEM"
				level.english_hint = "You cannot run a simulation while an object is in an impossible position.\nPlease move it to an acceptable position and retry."
				level.hint_time = 1
			level.emit_signal("level_hint")
	else:
		if level.running:
			level.level_stop()
	rsb.pressed = level.running

func _focus_on(obj):
	camera.position = obj.position

func _level_started():
	rsb.pressed = true
	win_screen.visible = false
	# win_screen_continue.disabled = true

func _level_stopped():
	rsb.pressed = false
	# if win_screen.visible:
	# win_screen_continue.disabled = false

func _on_WinScreenBack_pressed():
	if level.running:
		level.level_stop()
	win_screen.visible = false

func _on_WinScreenContinue_pressed():
	# this changes the music to the standard variant
	# this is important if two levels in a row have the same music
	level.level_stop()
	Yank.start(load("res://outer/interlevel_router.tscn"), level_id)

func _on_HintAdvance_pressed():
	level.advance_hint()


func _on_RTMQuit_pressed():
	Yank.start(load("res://outer/menu.tscn"), "")

func _on_RTMBack_pressed():
	rtm_screen.visible = false

func _on_RTM_pressed():
	rtm_screen.visible = true

func _on_LoadButton_pressed():
	level.load_savedata(GlobalFlags.core.get_value("solutions", level_id, ""))

func _on_SaveButton_pressed():
	_save_and_complete()
