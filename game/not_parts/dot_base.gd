class_name MSPCDotBase
extends RigidBody2D

onready var level: MSPCLevel = get_parent()

var packed_scene: PackedScene
var spawner: Node2D

var time_before_show: float = 0.1

func _init():
	visible = false

func _ready():
	level.connect("level_stopped", self, "start_die")

var dying: bool = false

func _physics_process(delta):
	if time_before_show >= 0.0:
		time_before_show -= delta
		if time_before_show < 0.0:
			visible = true
	var exerted: Vector2 = Vector2()
	if not dying:
		for v in level.parts:
			if v is MSPCGravitySource:
				var ofs = position - v.position
				var dv = ofs.length()
				if dv >= 0.001:
					exerted -= ofs.normalized() * (v.moon_gravity / dv)
	linear_velocity += delta * exerted

func start_die():
	if not dying:
		dying = true
		_start_die_internal()

func _start_die_internal():
	linear_velocity *= 0.125
	collision_layer = 0
	collision_mask = 0
	$AnimationPlayer.play("die")

func _die_finish():
	queue_free()
