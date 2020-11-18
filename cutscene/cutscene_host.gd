extends Node2D

var id
onready var viewport2 = $v
onready var viewport2_camera = $v/Camera2D
onready var sprite = $Sprite

func setup(i):
	id = i
	var ca: AnimationPlayer = load("res://cutscenes/" + id + ".tscn").instance()
	viewport2.add_child(ca)
	ca.connect("animation_finished", self, "_done")
	Yank.complete()

func _done(name):
	Yank.start(load("res://outer/interlevel_router.tscn"), id)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			_done("")

func _process(_delta):
	var sz = get_viewport().size
	var zoom = min(sz.x / 1280.0, sz.y / 720.0)
	viewport2_camera.zoom = Vector2(1 / zoom, 1 / zoom)
	viewport2.size = Vector2(1280, 720) * zoom
	# this is needed to get it to adjust properly
	sprite.texture = null
	sprite.texture = viewport2.get_texture()
	# print(sprite.texture.get_size())
