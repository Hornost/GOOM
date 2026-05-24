extends Node3D
class_name GMapMesh
@export var MESHES_LIGHT_LEVEL: Array[float] = []
func update(gmap: GMap,item: GMapGridItem):
	pass
func update_material(item: GMapGridItem, light_level = -1):
	var meshes = get_children()
	for i in range(meshes.size()):
		var mesh = get_children()[i]
		if mesh is MeshInstance3D:
			if light_level == -1:
				mesh.mesh = GMapStyles.meshes[mesh.name.split("[")[1].replace("]","")][item.style][GMapGridItem.MAX_LIGHT_LEVEL-1-item.light_level]
			else: 
				mesh.mesh = GMapStyles.meshes[mesh.name.split("[")[1].replace("]","")][item.style][clamp(GMapGridItem.MAX_LIGHT_LEVEL-1-light_level+(1.0-MESHES_LIGHT_LEVEL[i])*GMapGridItem.MAX_LIGHT_LEVEL,0,GMapGridItem.MAX_LIGHT_LEVEL)]
