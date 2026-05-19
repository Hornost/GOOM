@tool

extends TextureRect
@export_tool_button("Update") var update_button = update
@export var frame_idx: int = 0
@export var atlas: AtlasTexture
func _enter_tree() -> void:
	set_atlas(atlas)
func set_atlas(atlas: AtlasTexture):
	self.atlas = atlas
	texture = atlas
	update()
func update():
	if atlas:
		atlas.region.position.x = atlas.region.size.x * frame_idx
