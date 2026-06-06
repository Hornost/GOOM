extends Resource
class_name GMapGenerator
var room_iteration_count = 2**8
func generate()->GMap:
	var gmap = GMap.new()
	#generate rooms
	var last = Vector3i.ZERO
	for i in range(room_iteration_count):
		if i == 0:
			pass
		elif i == room_iteration_count:
			pass
		else:
			var pos = Vector3i.ZERO
			var iteration_count = 0
			while true:
				iteration_count += 1
				var rand = randi_range(0,4)
				if rand == 0: pos = last + Vector3i(0,0,1)
				if rand == 1: pos = last + Vector3i(0,0,-1)
				if rand == 2: pos = last + Vector3i(1,0,0)
				if rand == 3: pos = last + Vector3i(-1,0,0)
				if iteration_count >= 4: break
				if !gmap.get_item(pos): break
				
			if !gmap.get_item(pos):
				var style = ["foam_pressured","foam"].pick_random()
				gmap.grid.append(room(pos,style,GMapGridItem.MAX_LIGHT_LEVEL-1))
				if randi_range(0,100)<=25: gmap.grid.append(room(pos+Vector3i(0,1,0),style,GMapGridItem.MAX_LIGHT_LEVEL-1))
			last = pos
		#
	#for item in gmap.grid:
		#item.light_level = randi_range(0,3) 
	return gmap
static func room(style,light_level,args = []):
	var room = GMapRoom.new()
	room.style = style
	room.args = args
	room.light_level = light_level
	return room
