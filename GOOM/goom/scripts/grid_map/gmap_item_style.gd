extends Resource
class_name GMapItemStyle
@export var texture_names = ["wall","floor","roof"]
@export var texture_atlas: Texture2D
func generate_materials()->Dictionary:
	var materials = {}
	for i in range(texture_names.size()):
		var texture_materials = []
		for j in range(4): #max light level
			var material = StandardMaterial3D.new()
			material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			material.albedo_texture = texture_atlas
			material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
			material.uv1_scale = Vector3(0.25,0.125,1.0)
			material.uv1_offset.x = j*0.25
			material.uv1_offset.y = i*0.125
			texture_materials.append(material)
		materials.merge({texture_names[i]:texture_materials})
		
	return materials
