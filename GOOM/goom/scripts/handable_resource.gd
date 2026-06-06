extends Resource
class_name HandableResource
@export var name = "blank"
@export_category("Viewmodel Settings")
@export var viewmodel: ViewmodelResource
func input(event: InputEvent, hc: HandableController):
	pass
func enter(hc: HandableController):
	pass
func process(hc: HandableController, delta: float):
	pass
func holster_process(hc: HandableController, delta: float):
	pass
func exit(hc: HandableController):
	pass
func create_timer(hc: HandableController, wait_time: float) -> SceneTreeTimer:
	return hc.get_tree().create_timer(wait_time)
