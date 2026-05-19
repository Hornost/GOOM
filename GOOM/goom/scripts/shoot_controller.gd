extends Node
class_name ShootController
var player_pawn: Node3D
var fps: Node3D
var decal_controller: DecalController
var hitscan_info
func _ready() -> void:
	player_pawn = %player_pawn
	fps = %fps
	decal_controller = %decal_controller
func shoot_hitscan(pos: Vector3, rotation: Vector3, distance: float, damage: float):
	var info = hitscan(pos,rotation,distance)
	if info:
		var body = info[0]
		#%hitscan_ray.global_position = pos
		#%hitscan_ray.global_rotation = rotation
		#%hitscan_ray.target_position = Vector3(0,0,-distance)
		#var body = %hitscan_ray.body
		#var point = %hitscan_ray.point
		if body:
			if body is Entity:
				body.damage(damage)
			elif body is StaticBody3D:
				decal_controller.create_decal(info[1],info[2])
	#
	#reset()
	
func destruct(at_pos: Vector3i):
	var gmap = get_parent().get_parent().gmap
	gmap.set_item(GMapGenerator.room(at_pos,"destruct",3))

	
	
func hitscan(pos: Vector3, rotation: Vector3, distance: float):
	%hitscan_ray.global_position = pos
	%hitscan_ray.global_rotation = rotation
	%hitscan_ray.target_position = Vector3(0,0,-distance)
	var info = fetch()
	return info
func fetch():
	%hitscan_ray.force_raycast_update()
	if %hitscan_ray.is_colliding():
		var body = %hitscan_ray.get_collider()
		var point = %hitscan_ray.get_collision_point()
		var normal = %hitscan_ray.get_collision_normal()
		var info = [body,point,normal]
		return info
	else:
		return null
func reset():
	%hitscan_ray.global_position = Vector3.ZERO
	%hitscan_ray.global_rotation = Vector3.ZERO
	%hitscan_ray.target_position = Vector3.ZERO
	pass

func spawn_projectile():
	pass
