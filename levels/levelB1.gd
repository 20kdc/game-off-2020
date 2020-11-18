extends MSPCLevel

var hint_state = 0

func _ready():
	._ready()
	advance_hint()

func advance_hint():
	if hint_state == 0:
		hint_state = 1
		english_hint = "So! Now you're on my team, I'm going to introduce you to some of our more interesting tools.\nParticularly, explosive dots and linear accelerators!\nRemember, hit the button to the right when you want to hear more of what I have to say."
		hint_time = 8
		hint_advancable = true
		emit_signal("level_hint")
	elif hint_state == 1:
		hint_state = 2
		english_hint = "So, linear accelerators. When dots get near them, they pull through and accelerate them."
		hint_time = 4
		emit_signal("level_wants_focus_on", $yoink)
		emit_signal("level_hint")
	elif hint_state == 2:
		hint_state = 3
		english_hint = "Now, as for explosive dots. When they hit something, they explode - and if that's a dot, then the dot will be pushed in whatever direction the explosive dot was going.\nThe problem is getting them to hit. Remember that the slider to the right of the RUN/STOP button can slow down simulations, so that can help with finding issues."
		hint_time = 8
		emit_signal("level_wants_focus_on", $expspawner)
		emit_signal("level_hint")
	elif hint_state == 3:
		hint_state = 1
		english_hint = "That's it! Don't worry about the deadline, it's ages away. If you need things re-explained, just ask."
		hint_time = 4
		emit_signal("level_hint")
