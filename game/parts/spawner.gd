extends MSPCGravitySource

export var oneshot: bool = false
export var oneshot_counter: int = 1
export var speed: float = 0.125
onready var timer: Timer = $timer
export var scene: PackedScene = preload("../not_parts/dot.tscn")
export var is_dot: bool = true

var current_limit: int = 0

func _ready():
	timer.wait_time = speed

func _on_timer_timeout():
	if oneshot:
		if current_limit <= 0:
			timer.stop()
			return
		else:
			current_limit -= 1
	var dot: MSPCDotBase = scene.instance()
	dot.position = position
	dot.linear_velocity = to_global(Vector2(0, 320)) - to_global(Vector2())
	dot.packed_scene = scene
	dot.spawner = self
	if is_dot:
		level.dot_spawned()
	get_parent().add_child(dot)

func level_start():
	current_limit = oneshot_counter
	timer.start()

func level_stop():
	timer.stop()
