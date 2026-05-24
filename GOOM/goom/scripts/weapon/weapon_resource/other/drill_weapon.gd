extends WeaponResource
class_name DrillWeaponResource
@export var distance = 2

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
	#sc.shoot_hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,distance,damage)
	var info = sc.hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,distance)
	if info:
		var body = info[0]
		if body is StaticBody3D:
			sc.destruct(round(info[1])+-round(info[2]*0.5))
			pass
