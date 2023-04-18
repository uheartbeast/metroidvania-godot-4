class_name Projectile
extends Node2D

@export var speed = 250

var velocity = Vector2.ZERO

func update_velocity():
	velocity.x = speed
	velocity = velocity.rotated(rotation)

func _process(delta):
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_hitbox_body_entered(body):
	queue_free()

func _on_hitbox_area_entered(area):
	queue_free()
