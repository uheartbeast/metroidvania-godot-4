extends Node2D

@onready var level: = $LevelOne

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	Events.door_entered.connect(change_levels)

func change_levels(door : Door):
	var player = MainInstances.player as Player
	if not player is Player: return
	level.queue_free()
	var new_level = load(door.new_level_path).instantiate()
	add_child(new_level)
	level = new_level
	var doors = get_tree().get_nodes_in_group("doors")
	for found_door in doors:
		if found_door == door: continue
		if found_door.connection != door.connection: continue
		var yoffset = player.global_position.y - door.global_position.y
		player.global_position = found_door.global_position + Vector2(0, yoffset)
