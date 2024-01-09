class_name Projectile
extends Node2D

const ExplosionEffectScene = preload("res://effects/explosion_effect.tscn")

@export var speed = 250

var velocity = Vector2.ZERO

func update_velocity():
	velocity.x = speed
	velocity = velocity.rotated(rotation)

func _ready():
	Sound.play(Sound.bullet, randf_range(0.6, 1.2))

func _process(delta):
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_hitbox_body_entered(body):
	Utils.instantiate_scene_on_level(ExplosionEffectScene, global_position)
	queue_free()

func _on_hitbox_area_entered(area):
	Utils.instantiate_scene_on_level(ExplosionEffectScene, global_position)
	queue_free()
