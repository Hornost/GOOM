extends GMapMesh
class_name GMapMeshRoom
func update(gmap: GMap, item: GMapGridItem, pos: Vector3i):
	if gmap.has_item(pos + Vector3i(0,0,1)): disable($"wall_z+ [wall]")
	if gmap.has_item(pos + Vector3i(0,0,-1)): disable($"wall_z- [wall]")
	if gmap.has_item(pos + Vector3i(1,0,0)): disable($"wall_x+ [wall]")
	if gmap.has_item(pos + Vector3i(-1,0,0)): disable($"wall_x- [wall]")
	if gmap.has_item(pos + Vector3i(0,1,0)): disable($"roof [roof]")
	if gmap.has_item(pos + Vector3i(0,-1,0)): disable($"floor [floor]")
	
	disable($"dioganal_roof_z+ [ramp]")
	disable($"dioganal_roof_z- [ramp]")
	disable($"dioganal_roof_x+ [ramp]")
	disable($"dioganal_roof_x- [ramp]")
	
	if item.args.size()>0:
		if item.args.has("dioganal_roof"): 
			if !gmap.get_item(pos + Vector3i(0,0,1)): enable($"dioganal_roof_z+ [ramp]")
			if !gmap.get_item(pos + Vector3i(0,0,-1)): enable($"dioganal_roof_z- [ramp]")
			if !gmap.get_item(pos + Vector3i(1,0,0)): enable($"dioganal_roof_x+ [ramp]")
			if !gmap.get_item(pos + Vector3i(-1,0,0)): enable($"dioganal_roof_x- [ramp]")
	update_material(item)
func disable(node:Node3D):
	node.hide()
	node.get_child(0).get_child(0).disabled = true
func enable(node:Node3D):
	node.show()
	node.get_child(0).get_child(0).disabled = false
