class_name CyclicTrackPlayer
extends Node

var playing_a: AudioStreamPlayer
var playing_b: AudioStreamPlayer

var has_stream = false
var length = 0.0
var timer = 0.0
var a_b_swap = false
var volume = 1.0
var bus = "Master"

func _init():
	playing_a = AudioStreamPlayer.new()
	playing_a.volume_db = linear2db(0.0)
	add_child(playing_a)
	playing_b = AudioStreamPlayer.new()
	playing_b.volume_db = linear2db(0.0)
	add_child(playing_b)
	set_process(false)

func set_stream(trk, l, p):
	playing_a.stop()
	playing_b.stop()
	_update_volume()
	playing_a.bus = bus
	playing_b.bus = bus
	playing_a.stream = trk
	playing_b.stream = trk
	playing_a.play(p)
	length = l
	timer = p
	has_stream = trk != null
	set_process(has_stream)

func _process(delta):
	if not has_stream:
		return
	timer += delta / Engine.time_scale
	var restart = false
	while timer >= length:
		timer -= length
		restart = true
	if restart:
		if a_b_swap:
			playing_a.play()
		else:
			playing_b.play()
		a_b_swap = not a_b_swap
	_update_volume()

func _update_volume():
	# print("updating volume: " + str(volume))
	playing_a.volume_db = linear2db(volume)
	playing_b.volume_db = playing_a.volume_db
	
