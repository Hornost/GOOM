@tool

extends Node
@export var debug_item: InventoryItem
@export_tool_button("Update Item") var update_item_tool_button = (func():
	%viewmodel.viewmodel_sprite.set_atlas(debug_item.resource.viewmodel.viewmodel_atlas)
	%viewmodel_animation_tree.tree_root = debug_item.resource.viewmodel.animation_tree
	)
@export_tool_button("Erase Item") var erase_item_tool_button = (func():
	%viewmodel.viewmodel_sprite.set_atlas(null)
	)
