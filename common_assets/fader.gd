extends Node

var overlay: ColorRect
var overlay_layer: CanvasLayer

var target_state: float = 0.0
var state: float = 0.0

signal reached_target()

func _init():
	overlay = ColorRect.new()
	overlay_layer = CanvasLayer.new()
	overlay_layer.add_child(overlay)
	overlay.anchor_right = 1
	overlay.anchor_bottom = 1
	overlay.visible = false
	overlay.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	overlay.size_flags_vertical = Control.SIZE_EXPAND_FILL
	add_child(overlay_layer)

func _process(delta):
	var ef_delta = delta * 2.0
	if target_state > state:
		state = min(state + ef_delta, target_state)
	else:
		state = max(state - ef_delta, target_state)
	if state == target_state:
		emit_signal("reached_target")
	overlay.modulate = lerp(Color(0, 0, 0, 0), Color(0, 0, 0, 1), state)
	overlay.visible = state > 0
