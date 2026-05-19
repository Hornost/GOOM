extends Node
func _enter_tree() -> void:
	%inventory_controller.changed_item.connect(set_viewmodel)
	%weapon_controller.shoot.connect(func(shoot_controller):play("Trigger"))
func set_viewmodel(item: InventoryItem):
	%viewmodel_sprite.texture = item.resource.viewmodel.viewmodel_atlas
	%viewmodel_animation_controller.add_animation_library(item.resource.name,item.resource.viewmodel.animation_library)
	%viewmodel_animation_tree.tree_root = item.resource.viewmodel.animation_tree
	%viewmodel_animation_tree.get("parameters/playback").travel("Start")
func play(animation_name: String):
	%viewmodel_animation_tree.get("parameters/playback").travel(animation_name)
	#%viewmodel_animation_controller.play(%inventory_controller.current_item.resource.name +"/"+animation_name)
