extends BotAI
class_name BotWalkingEnemyAI
func think():
	direction = Vector3(rng.randf_range(-1,1),0,rng.randf_range(-1,1)).normalized()
	var _velocity = direction * speed
	velocity_update(_velocity)
