extends Node
class_name ViewmodelController

var viewmodel_animation_controller: AnimationPlayer

var walk_progress = 0.0
var viewmodel_scale_offset = 0.0
var viewmodel_offset = Vector2.ZERO
var viewmodel_color = Color.WHITE

var is_focused = false
func _enter_tree() -> void:
	viewmodel_animation_controller = %viewmodel.viewmodel_animation_controller
	%inventory_controller.changed_item.connect(set_viewmodel)
	%inventory_controller.changed_item.connect(func(to_item):
		viewmodel_offset=Vector2.ZERO
		viewmodel_scale_offset = 0.0
		viewmodel_color = Color.WHITE
		)
var is_inspecting = false
func _process(delta: float) -> void:
	var input_offset = Vector2.ZERO
	var mouse_input_offset = Vector2.ZERO
	var sway_mod = %handable_controller.current_handable.viewmodel.sway_mod
	
	var scale_offset = 0.0
	
	var walk_offset = Vector2.ZERO
	
	if !is_focused:
		input_offset = Vector2(0.2 * %player_pawn.input_dir.x * %viewmodel.viewmodel_viewport.size.x * sway_mod,
			0.2 * -%player_pawn.input_dir.y * %viewmodel.viewmodel_viewport.size.y * abs(-sway_mod))
		mouse_input_offset = 1000 * Vector2(1.25 * %fps.look_dir.x * sway_mod,
			1.0 * -%fps.look_dir.y * -sway_mod)
		scale_offset = (abs(0.2 * %player_pawn.input_dir.x) + (0.2 * %player_pawn.input_dir.y) + abs(10 * %fps.look_dir.x) + (10 * %fps.look_dir.y))/2 * sway_mod 
		if %player_pawn.input_dir != Vector2.ZERO:
			walk_progress += delta * 2
			walk_offset.x = sin(walk_progress*PI) * 50 * sway_mod
		else:
			walk_progress = 0
	else:
		input_offset = Vector2.ZERO
		mouse_input_offset = Vector2.ZERO
		scale_offset = 0.0
		walk_offset = Vector2.ZERO
	
	var inspect_offset = Vector2.ZERO
	if is_inspecting:
		inspect_offset = Vector2(0,-100)
		
	%viewmodel.viewmodel_scale_offset = lerp(%viewmodel.viewmodel_scale_offset,scale_offset,7*delta) + viewmodel_scale_offset
	%viewmodel.viewmodel_offset = %viewmodel.viewmodel_offset.lerp(walk_offset + input_offset + mouse_input_offset + inspect_offset,7*delta) + viewmodel_offset
	%viewmodel.viewmodel_color = viewmodel_color
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("TEST1"):
		inspect()

func inspect():
	is_inspecting = !is_inspecting
	
func set_frame_idx(idx:int):
	%viewmodel.viewmodel_sprite.frame_idx = idx
	%viewmodel.viewmodel_sprite.update()
func set_viewmodel(item: InventoryItem):
	%viewmodel.viewmodel_sprite.texture = item.resource.viewmodel.viewmodel_atlas
	#load_item_animation_library(item)
func load_item_animation_library(item: InventoryItem):
	if viewmodel_animation_controller.get_animation_list().size()>0:
		viewmodel_animation_controller.remove_animation_library(viewmodel_animation_controller.get_animation_library_list()[0])
	if item.resource.viewmodel.animation_library:
		viewmodel_animation_controller.add_animation_library(item.resource.name,item.resource.viewmodel.animation_library)
func play(name: String):
	viewmodel_animation_controller.play(%handable_controller.current_handable.name+"/"+name)
func is_playing(name: String):
	if viewmodel_animation_controller.current_animation and viewmodel_animation_controller.get_animation_library_list().size()>0:
		return viewmodel_animation_controller.current_animation.contains(name)
	else:
		return false
