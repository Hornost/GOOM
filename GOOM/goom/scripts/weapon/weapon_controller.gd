extends Node
@export var current_weapon: WeaponResource
signal shoot(shoot_controller: ShootController)
var is_triggered = false
func _enter_tree() -> void:
	%inventory_controller.changed_item.connect(func(to):
		if to.resource is WeaponResource:
			change_weapon(to.resource)
		else:
			current_weapon = null
		)
func _input(event: InputEvent) -> void:
	if !current_weapon: return
	if event.is_action_pressed("LMB"):
		is_triggered = true
	if event.is_action_released("LMB"):
		is_triggered = false
func _process(delta: float) -> void:
	if is_triggered and current_weapon:
		weapon_shoot(%shoot_controller)
	
func change_weapon(weapon:WeaponResource): 
	current_weapon = weapon
	if weapon is ClassicWeaponResource:
		pass
	
func weapon_shoot(shoot_controller: ShootController):
	current_weapon.shoot(shoot_controller)
	shoot.emit(shoot_controller)
