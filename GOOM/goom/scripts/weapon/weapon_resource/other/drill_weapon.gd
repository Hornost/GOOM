extends WeaponResource
class_name DrillWeaponResource
@export var distance = 2
func shoot(sc: ShootController):
	#sc.shoot_hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,distance,damage)
	var info = sc.hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,distance)
	if info:
		var body = info[0]
		if body is StaticBody3D:
			sc.destruct(round(info[1])+-round(info[2]*0.5))
			pass
