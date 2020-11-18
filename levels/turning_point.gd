extends MSPCLevel

func level_stop():
	if dots_alive > 0:
		return
	if not turning_point_disable_spawner:
		turning_point_disable_spawner = true
		$spawner.add_child(preload("res://game/assets/noplace_warning.tscn").instance())
		emit_signal("were_going_meta")
	.level_stop()

func dot_arrived():
	.dot_arrived()
	english_hint_giver = "20kdc"
	english_hint = "Congratulations, you got the secret ending.\nJohn Natco takes you around the back for a 'celebration' of you passing his 'secret test'. Then he shoots you.\nAnd then he grows an identical clone, who you're now playing as."
	hint_time = 1
	emit_signal("level_hint")
	level_stop()

func dot_died():
	.dot_died()
	english_hint = "Well, that was easier than I thought it'd be. Congrats. I'm about to get a promotion."
	hint_time = 4
	music_edit = music_run
	emit_signal("level_hint")
	level_stop()
