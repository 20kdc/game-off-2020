extends Node

export var track: String
export var fancy: String = "IMPOSSIBLE"

func _ready():
	MusicManager.set_track(track, MusicManager.we_are_playing == fancy)

func stop(fo):
	MusicManager.set_track("", false)
	MusicManager.override_fo = fo
