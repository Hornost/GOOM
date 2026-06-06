extends Node
#global class
#class_name GMapMaterialsList
var materials = {}
var meshes = {}

var STYLES_PATH = "res://addons/gmap/assets/styles/"
var MESHES_PATH = "res://addons/gmap/assets/meshes/"

func _enter_tree() -> void:
	pregenerate()
func generate_mesh_variant_for_style(mesh: Mesh,materials: Array)->Array:
	var meshes = []
	for material in materials:
		var _mesh = mesh.duplicate()
		_mesh.material = material
		meshes.append(_mesh)
	return meshes
func pregenerate():

	for mesh_file_path in DirAccess.get_files_at(MESHES_PATH):
		var mesh_name = mesh_file_path.get_basename()
		meshes.merge({mesh_name:{}})
	for style_file_path in DirAccess.get_files_at(STYLES_PATH):
		var style_res = load(STYLES_PATH+style_file_path)
		var style_name = style_file_path.get_basename()
		var style_materials = style_res.generate_materials()
		materials.merge({style_name: style_materials})
		for mesh_file_path in DirAccess.get_files_at(MESHES_PATH):
			var mesh_res = load(MESHES_PATH+mesh_file_path)
			var mesh_name = mesh_file_path.get_basename()
			var mesh_materials = generate_mesh_variant_for_style(mesh_res,style_materials[mesh_name])
			meshes[mesh_name].merge({style_name:mesh_materials})
