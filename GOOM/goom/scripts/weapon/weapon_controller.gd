extends Node
class_name HandableController
var shoot_controller: ShootController
@export var current_handable: HandableResource
func _enter_tree() -> void:
	shoot_controller = %shoot_controller
	%inventory_controller.changed_item.connect(func(to):
		change_handable(to.resource))
func _process(delta: float) -> void:
	if current_handable:
		current_handable.process(self)
func _input(event: InputEvent) -> void:
	if current_handable:
		current_handable.input(event,self)
	pass
func change_handable(handable:HandableResource): 
	current_handable = handable
	if handable is ClassicWeaponResource:
		pass
