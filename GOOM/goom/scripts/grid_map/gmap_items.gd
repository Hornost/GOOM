class_name GMapItems
const GRID_SIZE = 1
const ITEMS_MESHES = {
	"room": preload("res://scenes/gmap/room.tscn")
}
static func to_local(global_position: Vector3)->Vector3i:
	return round(global_position)
