class_name Powerup
extends Area2D

func _ready():
	await get_tree().process_frame
	var id = WorldStash.get_id(self)
	var freed = WorldStash.retrieve(id, "freed")
	if freed: queue_free()

func pickup():
	var id = WorldStash.get_id(self)
	WorldStash.stash(id, "freed", true)
	queue_free()

func _on_body_entered(body):
	pickup()
