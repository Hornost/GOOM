extends Resource
class_name GMapItemStyle
@export var texture_names = ["wall","floor","roof","ramp"]
@export var texture_idx = [0,1,2,0]
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
			material.uv1_scale = Vector3(1,0.125,1.0)
			material.uv1_offset.y = texture_idx[i]*0.125
			material.albedo_color = Color.WHITE - Color.WHITE * j/4
			texture_materials.append(material)
		materials.merge({texture_names[i]:texture_materials})
		
	return materials
