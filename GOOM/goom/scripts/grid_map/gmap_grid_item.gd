extends Resource
class_name GMapGridItem
const MAX_LIGHT_LEVEL = 15
@export var light_level = MAX_LIGHT_LEVEL 
@export var style: String = "BLANK"
@export var args = []
func get_mesh()->String:
	return "BLANK"
