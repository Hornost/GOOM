extends Resource
class_name GMapGenerator
@export var cave_noise: FastNoiseLite
var rng = RandomNumberGenerator.new()
func generate()->GMap:
	var gmap = GMap.new()
	return gmap
func generate_chunk(chunk_pos: Vector3i)->GMapGridChunk:
	var chunk = GMapGridChunk.new()
	chunk.fill_empty()
	chunk.pos = chunk_pos
	for z in range(GMapGridChunk.CHUNK_SIZE):
		for y in range(GMapGridChunk.CHUNK_SIZE):
			for x in range(GMapGridChunk.CHUNK_SIZE):
				var value = get_value(cave_noise,Vector3(chunk_pos)*GMapGridChunk.CHUNK_SIZE+Vector3(x,y,z))
				var item = null
				if value > 0.1:
					item = room("destruct",15)
					chunk.set_item(Vector3(x,y,z),item)
	return chunk
func get_value(noise: FastNoiseLite,pos: Vector3):
	return noise.get_noise_3d(pos.x,pos.y,pos.z)
func randomize_noise(noise: FastNoiseLite):
	var AMPLITUDE = 1000000
	noise.offset = Vector3(rng.randf_range(-AMPLITUDE,AMPLITUDE),
	rng.randf_range(-AMPLITUDE,AMPLITUDE),
	rng.randf_range(-AMPLITUDE,AMPLITUDE))
static func room(style,light_level,args = []):
	var room = GMapRoom.new()
	room.style = style
	room.args = args
	room.light_level = light_level
	return room
