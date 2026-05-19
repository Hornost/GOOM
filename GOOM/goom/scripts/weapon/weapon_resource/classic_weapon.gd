extends WeaponResource
class_name ClassicWeaponResource
@export var hitscan_distance = 15
@export_enum("Hitscan","Projectile") var shoot_type = 0
func shoot(sc: ShootController):
	match shoot_type:
		0:
			sc.shoot_hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,hitscan_distance,damage)
