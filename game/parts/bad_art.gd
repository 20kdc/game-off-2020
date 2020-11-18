extends MSPCPart

var velocity: Vector2
var proxy: Node2D

var y_start = 0.0
var y_end = 0.0

func _ready():
	y_end = global_position.y
	velocity = global_transform.y * -25.0
	global_translate(-(velocity * 240))
	y_start = global_position.y

func _physics_process(delta):
	global_translate(velocity * delta)

func level_start():
	$bad_art.visible = false
	if proxy == null:
		proxy = preload("../not_parts/bad_art_with_colliders.tscn").instance()
		proxy.transform = transform
		get_parent().add_child(proxy)

func level_stop():
	$bad_art.visible = true
	if proxy != null:
		proxy.queue_free()
		proxy = null

func is_win_condition():
	return true

func win_condition():
	var pos = global_position.y
	if proxy != null:
		pos = proxy.global_position.y
	var progress = (pos - y_end) / (y_start - y_end)
	progress *= 0.95
	progress = max(0.0, min(1.0, progress))
	return progress
