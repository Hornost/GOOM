extends HandableResource
class_name DrillWeaponResource
@export var distance = 1

var is_triggered = false
var is_started = false
var is_reloading = false
#@export var start_time = 0.09
#@export var work_time = 0.5
var hit_status = 0.0
@export var hit_speed = 1.2
@export var hit_reload_speed = 0.2
#@export var reload_time = 4.5
func input(event: InputEvent, hc: HandableController):
	if event.is_action_pressed("SECONDARY_TRIGGER"):
		hc.viewmodel_controller.set_frame_idx(1)
	if event.is_action_released("SECONDARY_TRIGGER"):
		hc.viewmodel_controller.set_frame_idx(0)
	if event.is_action_pressed("TRIGGER") and !is_reloading:
		is_triggered = true
		#create_timer(hc,start_time).timeout.connect(func(): 
			#if is_triggered:
				#is_started = true
				#create_timer(hc,work_time).timeout.connect(func():reload(hc))
		#)
		is_started = true
		#create_timer(hc,work_time).timeout.connect(func():reload(hc))
		hc.viewmodel_controller.set_frame_idx(1)
	if event.is_action_released("TRIGGER") and !is_reloading:
		is_triggered = false
		is_started = false
		hc.viewmodel_controller.set_frame_idx(0)
func process(hc: HandableController, delta: float):
	if !is_reloading:
		if is_started:
			shoot(hc)
			shake_viewmodel(hc,12)
			hit_status += delta * hit_speed
			if hit_status >= 1.0:
				reload(hc)
	else:
		if hit_status == 0:
			is_reloading = false
	if !is_started:
		hc.viewmodel_controller.viewmodel_offset = hc.viewmodel_controller.viewmodel_offset.lerp(Vector2.ZERO,7*delta)
	hc.viewmodel_controller.viewmodel_scale_offset = hit_status*0.05
	hc.viewmodel_controller.viewmodel_color = Color(hit_status*5 + 1.0,1.0-hit_status,1.0-hit_status)
func holster_process(hc: HandableController, delta: float):
	hit_status = move_toward(hit_status,0,delta*hit_reload_speed)
func shake_viewmodel(hc, radius):
	hc.viewmodel_controller.viewmodel_offset = Vector2(randf_range(-radius,radius),randf_range(-radius,radius))
func reload(hc: HandableController):
	is_started = false
	is_reloading = true
	hc.viewmodel_controller.set_frame_idx(0)
	hc.viewmodel_controller.viewmodel_offset = Vector2(0,50)
	#create_timer(hc,reload_time).timeout.connect(func():
		#is_reloading = false
		#)
	
func shoot(hc: HandableController):
	var sc = hc.shoot_controller
	#sc.shoot_hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,distance,damage)
	var info = sc.hitscan(sc.player_pawn.global_position,sc.fps.global_rotation,distance)
	if info:
		var body = info[0]
		if body is StaticBody3D:
			sc.destruct(round(info[1])+-round(info[2]*0.5))
			pass
