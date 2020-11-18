extends MSPCLevel

var timer = 240.0
var timer_state = 5

func _process(delta):
	timer -= delta
	if timer >= 0.0:
		english_level_gimmick = (str(int(floor(timer / 60))).pad_zeros(2)) + ":" + (str(int(floor(timer)) % 60).pad_zeros(2))
	if timer_state == 5:
		if timer <= 235.0:
			emit_signal("level_wants_focus_on", $moon_upper)
			timer_state = 0
	elif timer_state == 0:
		if timer <= 180.0:
			english_hint = "Oh, did I say moon? Why limit myself that far? A single universal government will be created, and I'll be on top."
			hint_time = 4
			emit_signal("level_hint")
			timer_state = 1
	elif timer_state == 1:
		if timer <= 120.0:
			english_hint = "Only two minutes. Why don't you surrender? I might let your pets live a while longer."
			hint_time = 4
			emit_signal("level_hint")
			timer_state = 2
	elif timer_state == 2:
		if timer <= 60.0:
			english_hint = "Two minutes, one minute. Time goes so fast these days, doesn't it? All of that time spent planning. But not for one's demise."
			hint_time = 4
			emit_signal("level_hint")
			timer_state = 3
	elif timer_state == 3:
		if timer <= 20.0:
			english_hint = "I'd tell you to not say I didn't warn you, but nobody here will be saying anything again, will they?"
			hint_time = 4
			emit_signal("level_hint")
			timer_state = 4
	elif timer_state == 4:
		if timer <= 0.0:
			english_hint = "Goodbye."
			hint_time = 1
			emit_signal("level_hint")
			timer_state = -1
			run_stop_locked = true
			Yank.start(LevelDB.MODE_CUTSCENE, "under_pressure")

func override_win_ack():
	timer_state = -1
	return true
