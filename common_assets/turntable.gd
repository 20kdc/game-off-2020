class_name TurntableBase
extends Node2D

var offset: float = 0

func _ready():
	set_notify_transform(true)

func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		var frame = int((global_rotation_degrees + offset) / 5) % 72
		if frame < 0:
			frame += 72
		var xp = frame % 9
		var yp = int(floor(frame / 9))
		var spr: Sprite = get_parent()
		var sz = spr.texture.get_size() / Vector2(9, 8)
		spr.region_rect = Rect2(xp * sz.x, yp * sz.y, sz.x, sz.y)
