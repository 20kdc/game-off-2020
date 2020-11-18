extends HSlider


func _on_HSlider_value_changed(value):
	Engine.time_scale = value / 100
