extends Node
class_name HandableController
var shoot_controller: ShootController
var viewmodel_controller: ViewmodelController

var current_handable: HandableResource
func _enter_tree() -> void:
	shoot_controller = %shoot_controller
	viewmodel_controller = %viewmodel_controller
	%inventory_controller.changed_item.connect(func(to):
		viewmodel_controller.load_item_animation_library(to)
		change_handable(to.resource))
func _process(delta: float) -> void:
	if current_handable:
		current_handable.process(self)
func _input(event: InputEvent) -> void:
	if current_handable:
		current_handable.input(event,self)
	pass
func change_handable(handable:HandableResource): 
	if current_handable:
		current_handable.exit(self)
	current_handable = handable
	current_handable.enter(self)
