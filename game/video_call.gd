extends Control

func setup():
	$Timer.start()
	
func _on_Timer_timeout():
	visible = true
