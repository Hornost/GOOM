extends Resource
class_name GMapGridChunk
const CHUNK_SIZE = 8
var items: Array[Array] = [[[]]]
var pos: Vector3i = Vector3i.ZERO
func fill_empty():
	items.resize(CHUNK_SIZE)
	for y in range(items.size()):
		var _y: Array[Array] = []
		_y.resize(CHUNK_SIZE)
		for z in range(_y.size()):
			var _z: Array = []
			_z.resize(CHUNK_SIZE)
			_y[z] = _z
		items[y] = _y
func to_global_pos(pos):
	return pos + self.pos*CHUNK_SIZE
static func to_chunk_local_pos(global_pos: Vector3i):
	var local_pos = Vector3i(global_pos.x%CHUNK_SIZE,
	global_pos.y%CHUNK_SIZE,
	global_pos.z%CHUNK_SIZE)
	return local_pos
func get_item(pos: Vector3i):
	return items[pos.z][pos.y][pos.x]
func set_item(pos: Vector3i, item: Variant):
	items[pos.z][pos.y][pos.x] = item
