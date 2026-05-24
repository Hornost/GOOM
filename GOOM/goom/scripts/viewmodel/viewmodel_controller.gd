extends Node
class_name ViewmodelController

var viewmodel_animation_controller: AnimationPlayer
func _enter_tree() -> void:
	viewmodel_animation_controller = %viewmodel.viewmodel_animation_controller
	%inventory_controller.changed_item.connect(set_viewmodel)
func set_viewmodel(item: InventoryItem):
	%viewmodel.viewmodel_sprite.texture = item.resource.viewmodel.viewmodel_atlas
	#load_item_animation_library(item):
func load_item_animation_library(item: InventoryItem):
	viewmodel_animation_controller.remove_animation_library(viewmodel_animation_controller.get_animation_library_list()[0])
	viewmodel_animation_controller.add_animation_library(item.resource.name,item.resource.viewmodel.animation_library)
func play(name: String):
	viewmodel_animation_controller.play(%handable_controller.current_handable.name+"/"+name)
