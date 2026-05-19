extends Node
@export var current_item: InventoryItem
signal changed_item(to_item: InventoryItem)

func _ready() -> void:
	change_item(load("res://assets/resources/items/test1.tres"))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		change_item(load("res://assets/resources/items/empty.tres"))
	elif event.is_action_pressed("2"):
		change_item(load("res://assets/resources/items/test1.tres"))
	elif event.is_action_pressed("3"):
		change_item(load("res://assets/resources/items/drill.tres"))

func change_item(item: InventoryItem):
	current_item = item
	changed_item.emit(item)
