class_name Door
extends Area2D

@export_file("*.tscn") var new_level_path
@export var connection : DoorConnection

@onready var right_cast = $RightCast
@onready var left_cast = $LeftCast

func get_direction():
	if left_cast.is_colliding():
		return -1
	if right_cast.is_colliding():
		return 1
	return 0

func _physics_process(delta):
	var player = MainInstances.player as Player
	if not player is Player: return
	if overlaps_body(player) and new_level_path:
		var player_direction = sign(player.velocity.x)
		var direction = get_direction()
		if player_direction == direction:
			print("door entered")
			Events.door_entered.emit(self)
