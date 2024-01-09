extends Node

var data = {}

func get_id(node, position):
	var level = MainInstances.level
	return level.name + "_" + node.name + "_" + str(position)

func stash(id, key, value):
	if not data.has(id): data[id] = {}
	data[id][key] = value

func retrieve(id, key):
	if not data.has(id): return
	if not data[id].has(key): return
	return data[id][key]
