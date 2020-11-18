extends Node

const ALL_SOUNDS = {
	"button_down": preload("button_down.ogg"),
	"button_up": preload("button_up.ogg"),
	"run_button_down": preload("run_button_down.ogg"),
	"run_button_up": preload("run_button_up.ogg"),
}

var sounds

func _init():
	sounds = []

func play(rest):
	if not GlobalFlags.flag_get("ui_sounds"):
		return
	var res: AudioStream = ALL_SOUNDS[rest]
	var killing = []
	for v in sounds:
		var vk: AudioStreamPlayer = v
		if not vk.playing:
			vk.queue_free()
			killing.append(v)
	for v2 in killing:
		sounds.erase(v2)
	var asp = AudioStreamPlayer.new()
	asp.bus = "UI"
	asp.stream = res
	asp.play()
	add_child(asp)
