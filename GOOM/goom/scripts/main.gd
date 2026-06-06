extends Node3D
@export var gmap: GMap
@export var gmap_generator: GMapGenerator
signal player_enter_in_new_room
signal player_enter_in_new_chunk(player_chunk_pos: Vector3i)
var player_pos = Vector3i.ZERO
var player_chunk_pos = Vector3i.ZERO

func _ready() -> void:
	Engine.max_fps = 60
	gmap.create_chunk(Vector3i.ZERO)
	var PREGENERATE_SIZE = 3
	for z in range(PREGENERATE_SIZE):
		for y in range(PREGENERATE_SIZE):
			for x in range(PREGENERATE_SIZE):
				gmap.create_chunk(Vector3i(x-PREGENERATE_SIZE/2,y-PREGENERATE_SIZE/2,z-PREGENERATE_SIZE/2))
	var size = PREGENERATE_SIZE*GMapGridChunk.CHUNK_SIZE/3
	for z in range(size):
		for y in range(size):
			for x in range(size):
				var pos = Vector3i(x-size/2,y-size/2,z-size/2)
				gmap.set_item(pos,gmap_generator.room("grid",15))
	%gmap_builder.build_gmap(gmap)
	
	#player_enter_in_new_room.connect(update_light)
	player_enter_in_new_chunk.connect(gmap.create_nearest_chunk)
	player_enter_in_new_room.emit()
	
func _process(delta: float) -> void:
	if player_pos != GMapItems.to_local($player.find_child("player_pawn").global_position):
		player_pos = GMapItems.to_local($player.find_child("player_pawn").global_position)
		player_enter_in_new_room.emit()
	if player_chunk_pos != GMap.to_chunk_grid($player.find_child("player_pawn").global_position):
		player_chunk_pos = GMap.to_chunk_grid($player.find_child("player_pawn").global_position)
		player_enter_in_new_chunk.emit(player_chunk_pos)

func update_light():
	for i in range(gmap.grid.size()):
		for z in range(GMapGridChunk.CHUNK_SIZE):
			for y in range(GMapGridChunk.CHUNK_SIZE):
				for x in range(GMapGridChunk.CHUNK_SIZE):
					var pos = Vector3i(x,y,z)
					var global_pos = gmap.grid[i].to_global_pos(pos)
					var item = gmap.grid[i].get_item(pos)
					var light_force = 0.5
					var _light_level = clampi(roundi((GMapGridItem.MAX_LIGHT_LEVEL-clamp(global_pos.distance_to(player_pos)*light_force,0,GMapGridItem.MAX_LIGHT_LEVEL))),0,GMapGridItem.MAX_LIGHT_LEVEL)
					var light_level = clampi(_light_level,0,GMapGridItem.MAX_LIGHT_LEVEL)#clampi(item.light_level+_light_level,0,3)
					if item:
						item.light_level = light_level
						%gmap_builder.update(gmap,item,global_pos)
		if i > 0:
			break
