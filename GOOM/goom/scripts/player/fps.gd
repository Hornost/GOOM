extends Camera3D
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 0.5
var camera: Camera3D = self
var mouse_captured: bool = false
var look_dir = Vector2.ZERO
var cam_rotation_x: float = 0
var cam_rotation_y: float = 0
var rot_offset_x: float =0
var resolution

signal rotating()
func _ready() -> void:
	resolution = get_viewport().size

func _process(delta: float) -> void:
	global_rotation.x = clamp(cam_rotation_x + rot_offset_x, -1.5, 1.5)
	global_rotation.y = cam_rotation_y
	if Input.is_action_just_pressed("ESC"):
		if mouse_captured:release_mouse()
		else: capture_mouse()
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()

func _rotate_camera(sens_mod: float = 1.0) -> void:
	rotating.emit()
	var delta = abs(look_dir.x*look_dir.y) * 1000
	var rot_speed = camera_sens * sens_mod * 3
	cam_rotation_y -= look_dir.x * rot_speed
	cam_rotation_x = clamp(cam_rotation_x - look_dir.y * rot_speed, -1.5, 1.5)
#
func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
func is_on_screen(pos,gap = 2)->bool:
	var angle = 0
	var a = (pos - global_position).normalized()
	var b = global_basis.z.normalized()
	var da = pow(a.x**2+a.y**2+a.z**2,2)
	var db = pow(b.x**2+b.y**2+b.z**2,2)
	var c = (a.dot(b))#/(da*db)
	angle = acos(c)
	if angle > gap:
		return true
	else:
		return false
	#if (pos.x <= 0 - gap or pos.y <= 0 - gap) or (pos.x >= resolution.x + gap or pos.y >= resolution.y + gap):
		#return false
	#else:
		#return true
	
