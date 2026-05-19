extends CharacterBody3D
class_name Entity
@export var health_point = 100
func damage(damage:float):
	health_point -= damage
	health_point = max(0,health_point)
	if health_point == 0:
		die()
func die():
	queue_free()
