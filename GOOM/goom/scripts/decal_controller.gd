extends Node
class_name DecalController
var DECAL = preload("res://scenes/decal.tscn")
var stack = []
var in_world = []
const STACK_SIZE = 64
func _enter_tree() -> void:
	pregenerate_stack()
func create_decal(pos,normal):
	if stack.size() == 0:
		push_back(grab_front(in_world),stack)
	var decal = grab_front(stack)
	if decal.get_parent() != self:
		add_child(decal)
	decal.global_position = pos
	decal.look_at_from_position(pos,pos+normal)
	decal.global_rotation_degrees.x += 90
	push_back(decal,in_world)
		
func grab_front(from):
	var el = from.pop_front()
	return el
func grab_back(from):
	var el = from.pop_back()
	return el
func push_front(el,to: Array):
	to.push_front(el)
func push_back(el,to: Array):
	to.push_back(el)
func pregenerate_stack():
	for i in range(STACK_SIZE):
		var _decal = DECAL.instantiate()
		_decal.name = str(i)
		stack.append(_decal)
	pass
