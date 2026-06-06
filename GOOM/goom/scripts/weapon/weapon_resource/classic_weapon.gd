extends WeaponResource
class_name ClassicWeaponResource
@export var damage = 15
@export var hitscan_distance = 15
@export_enum("Hitscan","Projectile") var shoot_type = 0
@export var shoot_delay = 0.2
var is_shooting = false
var is_triggered = false
func input(event: InputEvent, hc: HandableController):
	if event.is_action_pressed("TRIGGER") and !is_shooting:
		is_triggered = true
		hc.viewmodel_controller.is_focused = true
		shoot(hc)
	if event.is_action_released("TRIGGER"):
		hc.viewmodel_controller.is_focused = false
		is_triggered = false
func process(hc: HandableController, delta: float):
	hc.viewmodel_controller.viewmodel_offset = hc.viewmodel_controller.viewmodel_offset.lerp(Vector2.ZERO,15*delta)
func shoot(hc: HandableController):
	is_shooting = true
	hc.viewmodel_controller.set_frame_idx(1)
	var sc = hc.shoot_controller
	shake_viewmodel(hc,(0.1 * damage + 0.1 / shoot_delay)* abs(viewmodel.sway_mod))
	match shoot_type:
		0:
			sc.shoot_hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,hitscan_distance,damage)
			
	create_timer(hc,shoot_delay*1/2).timeout.connect(func():
		hc.viewmodel_controller.set_frame_idx(2)
		)
	create_timer(hc, shoot_delay).timeout.connect(func():
		if is_triggered:
			shoot(hc)
		else:
			is_shooting = false
			hc.viewmodel_controller.set_frame_idx(0)
		)
func shake_viewmodel(hc, radius):
	hc.viewmodel_controller.viewmodel_offset += -Vector2(randf_range(-radius/2,radius/2),randf_range(-radius/4,-radius))
func exit(hc: HandableController):
	is_triggered = false
	is_shooting = false
