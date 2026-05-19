extends Node

var is_triggered = false
var is_walking = false
var player_pawn_velocity = Vector3.ZERO
func _process(delta: float) -> void:
	is_triggered = %weapon_controller.is_triggered
	player_pawn_velocity = %player_pawn.velocity
	if abs(round(player_pawn_velocity*1)) != Vector3.ZERO:
		is_walking = true
	else:
		is_walking = false
