extends Node
class_name DamageNumberController
var DAMAGE_NUMBER = preload("res://scenes/damage_number.tscn")
var stack = []
var in_world = []
const STACK_SIZE = 128
func _enter_tree() -> void:
	pregenerate_stack()
func create_damage_number(pos,damage:int):
	if stack.size() == 0:
		push_back(grab_front(in_world),stack)
	var damage_number = grab_front(stack)
	if damage_number.get_parent() != self:
		add_child(damage_number)
	damage_number.global_position = pos
	damage_number.start(damage)
	damage_number.show()
	push_back(damage_number,in_world)
		
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
		var _damage_number = DAMAGE_NUMBER.instantiate()
		_damage_number.name = str(i)
		_damage_number.find_child("timer").timeout.connect(func():
			push_front(_damage_number,stack)
			_damage_number.hide()
			)
		stack.append(_damage_number)
	pass
