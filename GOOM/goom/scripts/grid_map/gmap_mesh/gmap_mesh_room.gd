extends GMapMesh
class_name GMapMeshRoom
func update(gmap: GMap,item: GMapGridItem):
	if gmap.get_item(Vector3i(position) + Vector3i(0,0,1)): disable($"wall_z+ [wall]")
	if gmap.get_item(Vector3i(position) + Vector3i(0,0,-1)): disable($"wall_z- [wall]")
	if gmap.get_item(Vector3i(position) + Vector3i(1,0,0)): disable($"wall_x+ [wall]")
	if gmap.get_item(Vector3i(position) + Vector3i(-1,0,0)): disable($"wall_x- [wall]")
	if gmap.get_item(Vector3i(position) + Vector3i(0,1,0)): disable($"roof [roof]")
	if gmap.get_item(Vector3i(position) + Vector3i(0,-1,0)): disable($"floor [floor]")
	if item.args.size()>0:
		if item.args.has("dioganal_roof"): 
			if !gmap.get_item(Vector3i(position) + Vector3i(0,1,0)): 
				if gmap.get_item(Vector3i(position) + Vector3i(0,0,1)): disable($"dioganal_roof_z+ [roof]")
				if gmap.get_item(Vector3i(position) + Vector3i(0,0,-1)): disable($"dioganal_roof_z- [roof]")
				if gmap.get_item(Vector3i(position) + Vector3i(1,0,0)): disable($"dioganal_roof_x+ [roof]")
				if gmap.get_item(Vector3i(position) + Vector3i(-1,0,0)): disable($"dioganal_roof_x- [roof]")
	else:
		disable($"dioganal_roof_z+ [roof]")
		disable($"dioganal_roof_z- [roof]")
		disable($"dioganal_roof_x+ [roof]")
		disable($"dioganal_roof_x- [roof]")
	update_material(item)
func disable(node:Node3D):
	node.hide()
	node.get_child(0).get_child(0).disabled = true
