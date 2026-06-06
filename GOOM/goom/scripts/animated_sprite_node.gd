@tool

extends Sprite2D
@export_tool_button("Update") var update_button = update
@export var frame_idx: int = 0:
	set(value):
		frame_idx = value
		update()
	get():
		return frame_idx
@export var atlas: AtlasTexture
func _enter_tree() -> void:
	set_atlas(atlas)
func set_atlas(atlas: AtlasTexture):
	self.atlas = atlas
	texture = atlas
	update()
func update():
	if texture:
		texture.region.position.x = texture.region.size.x * frame_idx
