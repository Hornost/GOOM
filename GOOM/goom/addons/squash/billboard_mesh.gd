extends MeshInstance3D

@export var sprite: Texture2D
@export var is_atlas = true
@export var mesh_scale = 1
@export var axis: Vector3 = Vector3.ONE
@export var up: Vector3 = Vector3.UP
var target: Node3D
var atlas_sprites: Array[Texture2D] = []
var angle = 0.0
var sprite_idx = 0
var camera: Camera3D
@export var initialize_on_ready = false
func _ready() -> void:
	if initialize_on_ready: _initialize()

func _initialize() -> void:
	var material = get_active_material(0)
	if material is StandardMaterial3D:
		material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		material.billboard_mode = BaseMaterial3D.BILLBOARD_FIXED_Y
		material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	var aspect = 1
	if !is_atlas:
		aspect = float(sprite.get_width()) / float(sprite.get_height())
	mesh.size.y = 1.0 * mesh_scale
	mesh.size.x = aspect * mesh_scale
	camera = get_viewport().get_camera_3d()
	if sprite:
		if !is_atlas:
			get_active_material(0).albedo_texture = sprite
		else:
			atlas_sprites = crop_to_smaller(sprite)
			get_active_material(0).albedo_texture = atlas_sprites[0]
	set_target(get_tree().root.get_camera_3d())

func _process(delta: float) -> void:
	if is_atlas:
		angle = get_angle(camera.global_position,get_parent().global_position,global_transform.basis.z)
		sprite_idx = get_idx(angle)
		set_sprite(sprite_idx)
	
func crop_to_smaller(texture: Texture2D):
	var arr: Array[Texture2D] = []
	var image = texture.get_image()
	image.decompress()
	var size_x = texture.get_width() / 8
	var size_y = texture.get_height()
	for i in range(8):
		var new_image = Image.new()
		new_image = new_image.create(size_x,size_y,false,image.get_format())
		new_image.blit_rect(image,Rect2i(Vector2i(i*size_x,0),Vector2i(size_x,size_y)),Vector2i(0,0))
		var _texture = ImageTexture.create_from_image(new_image)
		arr.append(_texture)
	return arr

func set_target(target):
	self.target = target
func get_angle(pos1:Vector3,pos2:Vector3,forward):
	return rad_to_deg((Vector3(pos1.x,pos2.y,pos1.z) - pos2).signed_angle_to(forward,Vector3.UP))
func set_sprite(idx:int):
	get_active_material(0).albedo_texture = atlas_sprites[idx]
func get_idx(angle)->int:
	var idx = 0
	if angle > -22.5 and angle < 22.6: idx = 0
	if angle >= 22.5 and angle < 67.5: idx = 7
	if angle >= 67.5 and angle < 112.5: idx = 6
	if angle >= 112.5 and angle < 157.5: idx = 5
	
	if angle <= -157.5 or angle >= 157.5: idx = 4
	if angle >= -157.5 and angle < -112.5: idx = 3
	if angle >= -112.5 and angle < -67.5: idx = 2
	if angle >= -67.5 and angle <= 22.4: idx = 1
	return idx
	
