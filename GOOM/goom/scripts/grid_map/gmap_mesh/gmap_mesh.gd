extends Node3D
class_name GMapMesh
func update(gmap: GMap,item: GMapGridItem):
	pass
func update_material(item: GMapGridItem, light_level = -1):
	for mesh in get_children():
		if mesh is MeshInstance3D:
			if light_level == -1:
				mesh.mesh = GMapStyles.meshes[mesh.name.split("[")[1].replace("]","")][item.style][3-item.light_level]
			else: 
				mesh.mesh = GMapStyles.meshes[mesh.name.split("[")[1].replace("]","")][item.style][3-light_level]
