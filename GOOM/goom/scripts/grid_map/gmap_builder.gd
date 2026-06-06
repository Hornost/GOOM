extends Node3D
var generated_meshes_chunks: Array[GMapGridChunk] = []
func build_chunk(gmap: GMap, chunk: GMapGridChunk):
	var mesh_chunk = place_chunk(chunk.pos)
	for z in range(GMapGridChunk.CHUNK_SIZE):
		for y in range(GMapGridChunk.CHUNK_SIZE):
			for x in range(GMapGridChunk.CHUNK_SIZE):
				var pos = Vector3i(x,y,z)
				var item = chunk.get_item(pos)
				if item:
					var mesh = place_mesh(gmap,item,mesh_chunk,chunk.to_global_pos(pos))
					mesh_chunk.set_item(Vector3i(x,y,z),mesh)
func build_gmap(gmap: GMap):
	for chunk in gmap.grid:
		build_chunk(gmap,chunk)
	gmap.updated.connect(updated)
	gmap.chunk_created.connect(func(gmap,chunk,at_pos):
		place_chunk(at_pos)
		)
func updated(gmap: GMap,item: GMapGridItem, at_pos: Vector3i):
	update(gmap,item,at_pos)
	update_nearest(gmap,at_pos)
	pass
func place_mesh(gmap: GMap,item: GMapGridItem, mesh_chunk:GMapGridChunk, at_pos: Vector3i):
	var mesh = GMapItems.ITEMS_MESHES[item.get_mesh()].instantiate()
	add_child(mesh)
	mesh.position = at_pos*GMapItems.GRID_SIZE
	mesh.update(gmap,item,at_pos)
	var _pos = mesh_chunk.to_chunk_local_pos(at_pos)
	mesh_chunk.set_item(_pos,mesh)
	return mesh
func place_chunk(at_pos: Vector3i):
	var mesh_chunk = GMapGridChunk.new()
	mesh_chunk.fill_empty()
	mesh_chunk.pos = at_pos
	generated_meshes_chunks.append(mesh_chunk)
	return mesh_chunk
func update(gmap: GMap, item: GMapGridItem, pos: Vector3i):
	if !item: return
	var mesh_chunk: GMapGridChunk = get_chunk(GMap.to_chunk_grid(pos))
	if mesh_chunk:
		var mesh = mesh_chunk.get_item(mesh_chunk.to_chunk_local_pos(pos))
		if mesh:
			mesh.update(gmap,item,pos)
		else:
			place_mesh(gmap,item,mesh_chunk,pos)
	pass
func get_chunk(local_pos: Vector3i):
	var chunk = null
	for _chunk in generated_meshes_chunks:
		if _chunk.pos == local_pos:
			chunk = _chunk
			break
	return chunk
func update_nearest(gmap: GMap, pos: Vector3i):
	update(gmap,gmap.get_item(Vector3i(1,0,0)+pos),Vector3i(1,0,0)+pos)
	update(gmap,gmap.get_item(Vector3i(-1,0,0)+pos),Vector3i(-1,0,0)+pos)
	update(gmap,gmap.get_item(Vector3i(0,0,1)+pos),Vector3i(0,0,1)+pos)
	update(gmap,gmap.get_item(Vector3i(0,0,-1)+pos),Vector3i(0,0,-1)+pos)
	update(gmap,gmap.get_item(Vector3i(0,1,0)+pos),Vector3i(0,1,0)+pos)
	update(gmap,gmap.get_item(Vector3i(0,-1,0)+pos),Vector3i(0,-1,0)+pos)
