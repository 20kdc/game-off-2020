extends Node

const LENGTHS = {
	"moment_of_realization_pre": 3.4285714285714284,
	"moment_of_realization_pre-r": 3.4285714285714284,
	"moment_of_realization": 54.857142857142854,
	"nov3-e": 109.71428571428571,
	"nov3-r": 109.71428571428571,
	"sad1": 114.0,
	"when_days_were_simple": 113.0,
	"nov3p2": 113.0,
	"nov3p3-e": 109.71428571428571,
	"nov3p3-r": 109.71428571428571,
	"nov4-e": 72.0, # NOT a guess!
	"nov4-r": 72.0,
	"nov4x6-e": 72.0,
	"nov4x6-r": 72.0,
	"nov4p1-e": 54.857142857142854,
	"nov4p1-r": 54.857142857142854,
	"nov5-e": 109.71428571428571,
	"nov5-r": 109.71428571428571
}

var sun: AudioStreamPlayer
var sun_fo_control = 0.0

var playing_old: CyclicTrackPlayer
var playing_new: CyclicTrackPlayer
var override_fo = 1.0
var crossfade = false

var we_are_playing: String = ""

func _init():
	sun = AudioStreamPlayer.new()
	sun.volume_db = linear2db(0.0)
	sun.autoplay = true
	sun.bus = "Music"
	sun.stream = preload("res://music/zzz_sun_loop.ogg")
	add_child(sun)

func set_track(track, fancy):
	if fancy:
		set_track_ex(track, "crossfade")
	else:
		set_track_ex(track, "normal")

func set_track_ex(track, mode):
	override_fo = 1.0
	crossfade = mode == "crossfade"
	if we_are_playing == track:
		return
	we_are_playing = track
	if playing_old != null:
		var kill_new_instead = false
		if playing_new != null:
			# if older has more volume, sacrifice newer track INSTEAD,
			# as this gives better continuity for A->B->C (i.e. cross-chapter)
			if playing_old.volume > playing_new.volume:
				kill_new_instead = true
		if kill_new_instead:
			playing_new.queue_free()
			playing_new = null
		else:
			playing_old.queue_free()
			playing_old = playing_new
			playing_new = null
	else:
		playing_old = playing_new
		playing_new = null
	if track != "":
		var data = load("res://music/" + track + ".ogg")
		var new_len = LENGTHS[track]
		playing_new = CyclicTrackPlayer.new()
		playing_new.bus = "Music"
		playing_new.volume = 0.0
		add_child(playing_new)
		if (mode == "crossfade") and playing_old != null:
			playing_new.set_stream(data, new_len, playing_old.timer)
		elif mode == "random":
			playing_new.set_stream(data, new_len, randf() * new_len)
		else:
			playing_new.set_stream(data, new_len, 0.0)

func _process(delta):
	delta /= Engine.time_scale
	var ok_to_add_new = true
	if playing_old != null:
		ok_to_add_new = crossfade
		playing_old.volume = max(0.0, playing_old.volume - (delta * override_fo))
		if playing_old.volume == 0:
			playing_old.queue_free()
			playing_old = null
	if playing_new != null:
		if ok_to_add_new:
			playing_new.volume = min(1.0, playing_new.volume + delta)
	# finally...
	if we_are_playing == "nov4-e" or we_are_playing == "nov4-r" or we_are_playing == "nov4x6-e" or we_are_playing == "nov4x6-r":
		sun_fo_control = min(1.0, sun_fo_control + delta)
	else:
		sun_fo_control = max(0.0, sun_fo_control - delta)
	sun.volume_db = linear2db(sun_fo_control)
