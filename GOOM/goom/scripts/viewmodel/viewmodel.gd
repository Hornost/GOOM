@tool
extends Control

@export var viewmodel_animation_controller: AnimationPlayer
@export var viewmodel_parent: Node
@export var viewmodel_sprite: Node
@export var viewmodel_viewport: Node
#@export var condition_controller: NodePath
@export var debug_item: InventoryItem

var viewmodel_offset = Vector2.ZERO
var viewmodel_scale_offset = 0.0
var viewmodel_color = Color.WHITE

func _ready() -> void:
	erase()
func _process(delta: float) -> void:
	viewmodel_parent.scale = Vector2.ONE * 1.2 * (1.0+viewmodel_scale_offset)
	viewmodel_parent.position = Vector2(320,320)/2 + viewmodel_offset
	viewmodel_sprite.self_modulate = viewmodel_color
func set_frame_idx(idx: int):
	%viewmodel_sprite.frame_idx = idx
@export_tool_button("Update Item") var update_item_tool_button = (func():
	viewmodel_sprite.set_atlas(debug_item.resource.viewmodel.viewmodel_atlas)
	%viewmodel_animation_controller.add_animation_library(debug_item.resource.name,debug_item.resource.viewmodel.animation_library)
	#%viewmodel_animation_tree.tree_root = debug_item.resource.viewmodel.animation_tree
	)
@export_tool_button("Erase Item") var erase_item_tool_button = (erase)
func erase():
	viewmodel_sprite.set_atlas(null)
	%viewmodel_animation_controller.remove_animation_library(debug_item.resource.name)
