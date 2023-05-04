class_name Powerup
extends Area2D

func _ready():
	var id = WorldStash.get_id(self)
	var freed = WorldStash.retrieve(id, "freed")
	if freed: queue_free()

func pickup():
	Sound.play(Sound.powerup)
	var id = WorldStash.get_id(self)
	WorldStash.stash(id, "freed", true)
	queue_free()

func _on_body_entered(body):
	pickup()
