class_name MSPCCursor
extends KinematicBody2D

var areas: Array
var dragging: bool
onready var level: MSPCLevel = get_parent()

var editable_target: MSPCPart
var ordinary_target: MSPCPart
var is_dragging: bool = false
var drag_start_offset: Vector2 = Vector2()
var shape_owner: int

func _init():
	shape_owner = create_shape_owner(self)
	areas = []

func _process(delta):
	_update_target()
	if level.mouse_left_down:
		collision_layer = 10
	else:
		collision_layer = 0
	if delta == 0:
		# AGAIN
		return
	# Note the custom implementation of move_and_slide
	# Specifically:
	#  + only one slide iteration is performed
	#  + this isn't physics_process so we're not supposed to use move_and_slide
	#  + it makes no sense to use a function that relies on delta-time
	#    for a known per-frame move
	var mvs = get_local_mouse_position()
	var coll = move_and_collide(mvs)
	if coll != null:
		move_and_collide(coll.remainder.slide(coll.normal))

func _update_target():
	var was_dragging = is_dragging
	is_dragging = false
	# drag
	if editable_target != null and level.mouse_left_down:
		is_dragging = true
		if not was_dragging:
			# drag start
			drag_start_offset = position - editable_target.position
			shape_owner_set_transform(shape_owner, Transform2D.IDENTITY.translated(-drag_start_offset))
			var circle = CircleShape2D.new()
			circle.radius = 8
			shape_owner_add_shape(shape_owner, circle)
		if _effectively_editable(editable_target):
			editable_target.position = position - drag_start_offset
	if was_dragging and not is_dragging:
		# drag end
		if editable_target != null:
			editable_target.emit_signal("dropped")
		shape_owner_clear_shapes(shape_owner)
	if not is_dragging:
		# find new target
		editable_target = null
		ordinary_target = null
		for v in areas:
			if v is MSPCPart:
				var target: MSPCPart = v
				if target.editable:
					editable_target = target
					ordinary_target = target
					return
				else:
					ordinary_target = target

func _on_selector_area_entered(area):
	# print(str(area) + ", +")
	areas.append(area)

func _on_selector_area_exited(area):
	# print(str(area) + ", -")
	areas.erase(area)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == BUTTON_WHEEL_DOWN:
				_rotate_target(5)
			elif event.button_index == BUTTON_WHEEL_UP:
				_rotate_target(-5)
	elif event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_1:
				_rotate_target(-5)
			elif event.scancode == KEY_2:
				_rotate_target(5)

func _rotate_target(angle):
	if editable_target != null:
		if _effectively_editable(editable_target):
			editable_target.rotation_degrees += angle

func _effectively_editable(target: MSPCPart):
	return target.editable and not level.running
