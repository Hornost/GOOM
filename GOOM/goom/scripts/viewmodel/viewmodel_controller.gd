extends Node
var viewmodel_animation_controller: AnimationPlayer
func _enter_tree() -> void:
	viewmodel_animation_controller = %viewmodel.viewmodel_animation_controller
	%inventory_controller.changed_item.connect(set_viewmodel)
func set_viewmodel(item: InventoryItem):
	%viewmodel.viewmodel_sprite.texture = item.resource.viewmodel.viewmodel_atlas
	if !viewmodel_animation_controller.has_animation_library(item.resource.name):
		viewmodel_animation_controller.add_animation_library(item.resource.name,item.resource.viewmodel.animation_library)
