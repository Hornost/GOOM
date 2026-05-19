extends Resource
class_name GMapGridItem
@export var light_level = 3 #0-3
@export var pos: Vector3i = Vector3i.ZERO
@export var style: String = "BLANK"
@export var args = []
func get_mesh()->String:
	return "BLANK"
