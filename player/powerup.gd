class_name Powerup
extends Area2D

func pickup():
	queue_free()

func _on_body_entered(body):
	pickup()
