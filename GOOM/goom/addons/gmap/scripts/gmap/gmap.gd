extends Resource
class_name GMap
#.gmap (grid map)
@export var grid: Array[GMapGridChunk]
signal chunk_created(gmap: GMap, chunk: GMapGridChunk, at_pos: Vector3i)
signal updated(gmap: GMap, item: GMapGridItem, at_pos: Vector3i)
#info: [idx,item]

func create_nearest_chunk(pos: Vector3i, radius = 3):
	for z in range(radius):
		for y in range(radius):
			for x in range(radius):
				var chunk_pos = pos+Vector3i(x-radius/2,y-radius/2,z-radius/2)
				create_chunk(chunk_pos)

func get_item(global_pos: Vector3i):
	return get_chunk_at_global_pos(global_pos).get_item(to_chunk_local_pos(global_pos))
func has_item(global_pos: Vector3i):
	if get_chunk_at_global_pos(global_pos) and get_chunk_at_global_pos(global_pos).get_item(to_chunk_local_pos(global_pos)):
		return true
	else:
		return false
func set_item(global_pos: Vector3i, item: GMapGridItem):
	get_chunk_at_global_pos(global_pos).set_item(to_chunk_local_pos(global_pos),item)
	updated.emit(self,item, global_pos)
func create_chunk(pos: Vector3i):
	var chunk = GMapGridChunk.new()
	chunk.pos = pos
	chunk.fill_empty()
	grid.append(chunk)
	chunk_created.emit(self, chunk, pos)
func set_chunk(chunk: GMapGridChunk):
	if !get_chunk(chunk.pos):
		grid.append(chunk)
	else:
		pass
		#blend
	chunk_created.emit(self, chunk, chunk.pos)
func get_chunk_at_global_pos(global_pos: Vector3i):
	return get_chunk(to_chunk_grid(global_pos))
static func to_chunk_local_pos(global_pos: Vector3i):
	return GMapGridChunk.to_chunk_local_pos(global_pos)
func get_chunk(local_pos: Vector3i):
	var chunk = null
	for _chunk in grid:
		if _chunk.pos == local_pos:
			chunk = _chunk
			break
	return chunk
static func to_chunk_grid(global_pos: Vector3i):
	return Vector3i(floor(Vector3(global_pos)/GMapGridChunk.CHUNK_SIZE))
