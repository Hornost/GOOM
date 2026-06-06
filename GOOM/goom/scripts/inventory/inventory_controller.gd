extends Node
class_name InventoryController
@export var current_item: InventoryItem
signal changed_item(to_item: InventoryItem)
var hotbar_inventory = []
func _ready() -> void:
	give_item(load("res://assets/resources/items/empty.tres"))
	give_item(load("res://assets/resources/items/pistol_tucan.tres"))
	give_item(load("res://assets/resources/items/chaindrill.tres"))
	give_item(load("res://assets/resources/items/minigun_susan.tres"))
	give_item(load("res://assets/resources/items/_test.tres"))
	
	change_item(0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		change_item(0)
	elif event.is_action_pressed("2"):
		change_item(1)
	elif event.is_action_pressed("3"):
		change_item(2)
	elif event.is_action_pressed("4"):
		change_item(3)
	elif event.is_action_pressed("5"):
		change_item(4)
func give_item(item: InventoryItem):
	hotbar_inventory.append(item.duplicate_deep(Resource.DEEP_DUPLICATE_ALL))
func change_item(idx: int):
	var item = hotbar_inventory[idx]
	current_item = item
	changed_item.emit(item)
#func change_item(item: InventoryItem):
	#current_item.resource.is_picked = false
	#current_item = item
	#current_item.resource.is_picked = true
	#changed_item.emit(item)
