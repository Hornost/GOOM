extends Node3D
var generated_meshes = []
func build_gmap(gmap: GMap):
	for item in gmap.grid:
		var mesh = place_mesh(gmap,item,item.light_level)
	#for i in range(gmap.grid.size()):
		#generated_meshes[i].update(gmap,gmap.grid[i])
	gmap.item_updated.connect(item_updated)
func item_updated(gmap: GMap, at_idx: int,item: GMapGridItem):
	if at_idx < generated_meshes.size():
		#remove_child(generated_meshes[at_idx])
		generated_meshes[at_idx].queue_free()
		generated_meshes.remove_at(at_idx)
	place_mesh(gmap,item,0)
	update_nearest(gmap,item.pos)
func place_mesh(gmap: GMap,item: GMapGridItem, light_level:int):
	var mesh = GMapItems.ITEMS_MESHES[item.get_mesh()].instantiate()
	add_child(mesh)
	mesh.position = item.pos*GMapItems.GRID_SIZE
	mesh.update(gmap,item)
	generated_meshes.append(mesh)
	return mesh
func update(gmap: GMap, pos: Vector3i):
	var info = gmap.get_item_info(pos)
	if info[0]:
		generated_meshes[info[0]].update(gmap,info[1])
func update_nearest(gmap: GMap, pos: Vector3i):
	update(gmap,Vector3i(1,0,0)+pos)
	update(gmap,Vector3i(-1,0,0)+pos)
	update(gmap,Vector3i(0,0,1)+pos)
	update(gmap,Vector3i(0,0,-1)+pos)
	update(gmap,Vector3i(0,1,0)+pos)
	update(gmap,Vector3i(0,-1,0)+pos)
	
