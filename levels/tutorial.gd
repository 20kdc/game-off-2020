extends MSPCLevel

var hint_state = 0

func advance_hint():
	if hint_state == 0:
		hint_state = 1
		english_hint = "First things first, this is the MOONSHOT itself, or at least it's representation anyway."
		hint_time = 4
		emit_signal("level_wants_focus_on", $spawner)
		emit_signal("level_hint")
	elif hint_state == 1:
		hint_state = 2
		english_hint = "This is the output - where we hypothetically want something delivered. Your goal is to get as much stuff, whatever that stuff may be, from the MOONSHOT to here as possible."
		hint_time = 4
		emit_signal("level_wants_focus_on", $win)
		emit_signal("level_hint")
	elif hint_state == 2:
		hint_state = 3
		english_hint = "This - and the one just like it to the bottom-left, near that red blocker - is another planetoid. If the cargo hits one of these, it's lost."
		hint_time = 4
		emit_signal("level_wants_focus_on", $moon_upper)
		emit_signal("level_hint")
	elif hint_state == 3:
		hint_state = 4
		english_hint = "As you know, by positioning a series of ropes and weights around various points, we can trick the universe into holding some things stationary under some conditions. This is a blocker, a giant metaphorical baseball glove attached to one of these mechanisms."
		hint_time = 6
		emit_signal("level_wants_focus_on", $blocker)
		emit_signal("level_hint")
	elif hint_state == 4:
		hint_state = 5
		run_stop_locked = false
		english_hint = "Now, this blocker is in the wrong place. I've unlocked your RUN/STOP button, so you can see why for yourself."
		hint_time = 4
		hint_advancable = false
		connect("level_started", self, "advance_hint", [], CONNECT_ONESHOT)
		emit_signal("level_hint")
	elif hint_state == 5:
		hint_state = 6
		run_stop_locked = true
		english_hint = "As you can see, the MOONSHOT fires a rapid stream of small capsules, known as dots. They then hit the blocker, and fall to the planetoid."
		hint_time = 4
		hint_advancable = true
		emit_signal("level_hint")
	elif hint_state == 6:
		hint_state = 7
		run_stop_locked = false
		english_hint = "You can control the simulation speed using the slider. Feel free to stop using the RUN/STOP button once you're done."
		hint_time = 4
		hint_advancable = false
		connect("level_stopped", self, "advance_hint", [], CONNECT_ONESHOT)
		emit_signal("level_hint")
	elif hint_state == 7:
		hint_state = 8
		run_stop_locked = true
		english_hint = "Now let's focus on basic navigation. Dragging with the right mouse button allows you to look around the blueprint."
		hint_time = 4
		hint_advancable = true
		emit_signal("level_hint")
	elif hint_state == 8:
		hint_state = 9
		english_hint = "The left mouse button can drag objects. Here, the only object you can do that to is the blocker."
		hint_time = 4
		hint_advancable = false
		$blocker.editable = true
		$blocker.connect("dropped", self, "advance_hint", [], CONNECT_ONESHOT)
		emit_signal("level_hint")
	elif hint_state == 9:
		hint_state = 10
		english_hint = "There are certain limits to where the mechanisms can hold an object stable, indicated by the striped borders."
		hint_time = 4
		hint_advancable = true
		emit_signal("level_hint")
	elif hint_state == 10:
		hint_state = 11
		english_hint = "You can rotate an object with either the mouse wheel, or the 1 and 2 keys on your keyboard."
		hint_time = 4
		hint_advancable = false
		emit_signal("level_hint")
	elif hint_state == 11:
		hint_state = -1
		english_hint = "Now you know all this, it should be simple enough for you to move the offending blocker to a stable location. I've unlocked your RUN/STOP button again."
		hint_time = 4
		run_stop_locked = false
		emit_signal("level_hint")

func _process(delta):
	._process(delta)
	if hint_state == 9:
		if len(get_editable_parts_in_noplace()) != 0:
			advance_hint()
	elif hint_state == 11:
		if abs($blocker.rotation_degrees) > 1:
			advance_hint()

