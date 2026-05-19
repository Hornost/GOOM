extends Resource
class_name GMap
#.gmap (grid map)
@export var grid: Array[GMapGridItem]
signal item_updated(gmap: GMap, at_idx: int, with_item: GMapGridItem)

func get_item(pos: Vector3i):
	var item = null
	for el in grid:
		if el.pos == pos:
			item = el
			break
	return item
func get_item_idx(pos: Vector3i):
	var idx = null
	for i in range(grid.size()):
		var el = grid[i]
		if el.pos == pos:
			idx = i
			break
	return idx
func get_item_info(pos: Vector3i):
	var idx = null
	var item = null
	for i in range(grid.size()):
		if grid[i].pos == pos:
			idx = i
			item = grid[i]
	return [idx,item]
func has_item(pos):
	var res = false
	for i in range(grid.size()):
		var el = grid[i]
		if el.pos == pos:
			res = true
			break
	return res
func set_item(item: GMapGridItem):
	if has_item(item.pos):
		replace_item(item)
	else:
		place_item(item)
func replace_item(item: GMapGridItem):
	var idx = get_item_idx(item.pos)
	#grid[idx] = item
	grid.remove_at(idx)
	grid.append(item)
	item_updated.emit(self,idx,item)
func place_item(item: GMapGridItem):
	grid.append(item) 
	item_updated.emit(self,grid.size(),item)
