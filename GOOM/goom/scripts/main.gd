extends Node3D
@export var gmap: GMap
@export var gmap_generator: GMapGenerator
signal player_enter_in_new_room
var player_pos = Vector3i.ZERO

func _ready() -> void:
	Engine.max_fps = 60
	
	gmap = gmap_generator.generate()
	#for el in gmap.grid:
		#print(el.pos)
	
	##build test room
	#var room = GMapRoom.new()
	#room.style = "grid"
	##room.args = ["dioganal_roof"]
	#room.light_level = 3
	#var size = 10
	#for y in range(1):
		#for x in range(size):
			#for z in range(size):
				#var _room = room.duplicate()
				#_room.pos = Vector3i(x-size/2,y,z-size/2)
				#gmap.grid.append(_room)
				
	%gmap_builder.build_gmap(gmap)
	
	player_enter_in_new_room.connect(update_light)
	player_enter_in_new_room.emit()
	
func _process(delta: float) -> void:
	if player_pos != GMapItems.to_local($player.find_child("player_pawn").global_position):
		player_pos = GMapItems.to_local($player.find_child("player_pawn").global_position)
		player_enter_in_new_room.emit()
func update_light():
	for i in range(gmap.grid.size()):
			var item = gmap.grid[i]
			var light_force = 0.5
			var _light_level = clampi(roundi((GMapGridItem.MAX_LIGHT_LEVEL-clamp(item.pos.distance_to(player_pos)*light_force,0,GMapGridItem.MAX_LIGHT_LEVEL))),0,GMapGridItem.MAX_LIGHT_LEVEL)
			var light_level = clampi(_light_level,0,GMapGridItem.MAX_LIGHT_LEVEL)#clampi(item.light_level+_light_level,0,3)
			%gmap_builder.generated_meshes[i].update_material(item,light_level)
