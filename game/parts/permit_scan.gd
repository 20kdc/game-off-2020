extends MSPCPart

signal dot_passed()

func _on_body_entered(body):
	if body is MSPCDotBase:
		if not body.dying:
			emit_signal("dot_passed")
