extends Node3D
var SPEED = 1
var direction: Vector3 = Vector3.ZERO

func start(damage: int):
	$label.text = str(damage)
	$timer.start()
	direction = Vector3(0,1,0)
	direction = Vector3(randf_range(-1,1),randf_range(0,1),randf_range(-1,1)).normalized()
func _process(delta: float) -> void:
	if visible:
		var time = 1.0-$timer.time_left/$timer.wait_time
		global_position += direction*delta*SPEED*(1.0-time) * Vector3(0.5,1,0.5)
		var a = 1.0-smoothstep(0.9,1.0,time)
		$label.modulate = Color(1,1,1,a)
		$label.outline_modulate = Color(0,0,0,a)
