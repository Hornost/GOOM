extends WeaponResource
class_name ClassicWeaponResource
@export var hitscan_distance = 15
@export_enum("Hitscan","Projectile") var shoot_type = 0
var is_triggered = false
func input(event: InputEvent, hc: HandableController):
	if event.is_action_pressed("LMB"):
		is_triggered = true
	if event.is_action_released("LMB"):
		is_triggered = false
func process(hc: HandableController):
	if is_triggered:
		shoot(hc.shoot_controller)
func shoot(sc: ShootController):
	match shoot_type:
		0:
			sc.shoot_hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,hitscan_distance,damage)
