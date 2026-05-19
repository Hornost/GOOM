extends Resource
class_name BotAI

var bot_pawn_velocity = Vector3.ZERO
var bot_pawn_position = Vector3.ZERO

@export var speed = 1.5

var desired_velocity = Vector3.ZERO
var direction = Vector3.ZERO
signal velocity_changed(from_velocity: Vector3, to_velocity: Vector3)

var rng = RandomNumberGenerator.new()

func think():
	direction = Vector3(1,0,0)
	var _velocity = direction * speed
	velocity_update(_velocity)
	
func velocity_update(_velocity: Vector3):
	desired_velocity = _velocity
	velocity_changed.emit(desired_velocity,_velocity)
	
