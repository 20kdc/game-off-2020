class_name MSPCLevel
extends Node2D

export var english_name: String
export(String, MULTILINE) var english_dev_commentary: String
export var english_hint_giver: String
export var english_level_gimmick: String
export(String, MULTILINE) var english_hint: String

export var music_edit: String
export var music_run: String
export var is_musical_intro: bool = false
export var music_other_transition: String = "IMPOSSIBLE"

export var hint_time: float = 4.0
export var hint_advancable: bool
export var run_stop_locked: bool = false

export var is_turning_point: bool = false
var turning_point_disable_spawner: bool = false

export var is_1995_ui: bool = false
export var has_sun: bool = false
export var no_mischief: bool = false

onready var camera_start: Position2D = $"core/camera_start"

# edit/run state
var parts: Array
var mouse_left_down: bool = false

# run state
var dots_spawned: int = 0
var dots_alive: int = 0
var running: bool = false

signal level_started()
signal level_stopped()
signal level_hint()
signal level_wants_focus_on(obj)
signal were_going_meta()

func _ready():
	if MusicManager.we_are_playing == music_other_transition:
			MusicManager.set_track(music_edit, true)
	else:
		if not is_musical_intro:
			MusicManager.set_track_ex(music_edit, "random")
		else:
			MusicManager.set_track(music_edit, false)
	parts = []
	for v in get_children():
		if v is MSPCPartBase:
			parts.append(v)

func _process(delta):
	pass

func get_editable_parts_in_noplace():
	if turning_point_disable_spawner:
		return [$spawner]
	return []

func save_savedata():
	var sv = ""
	for v in parts:
		if v.editable:
			sv += ":" + v.name + ";" + v.save_savedata()
	return sv

func load_savedata(sv: String):
	for pd in sv.split(":"):
		var dat = pd.split(";")
		var dat2 = get_node_or_null(dat[0])
		if dat2 != null:
			if dat2.editable:
				dat2.load_savedata(dat)

func level_start():
	if running:
		push_warning("level was already started")
		return
	running = true
	dots_spawned = 0
	dots_alive = 0
	for v in parts:
		v.level_start()
	emit_signal("level_started")
	MusicManager.set_track(music_run, true)

func level_stop():
	if not running:
		push_warning("level was not running")
		return
	running = false
	for v in parts:
		v.level_stop()
	emit_signal("level_stopped")
	MusicManager.set_track(music_edit, true)

func calc_win_fraction():
	var total = 0.0
	var total_max = 0.0
	for v in parts:
		if v.is_win_condition():
			total += v.win_condition()
			total_max += 1.0
	if total_max == 0.0:
		total = 1.0
		total_max = 1.0
	return total / total_max

func dot_spawned():
	dots_spawned += 1
	dots_alive += 1

func dot_arrived():
	pass

func dot_died():
	dots_alive -= 1

func advance_hint():
	pass

func override_win_ack():
	return false
