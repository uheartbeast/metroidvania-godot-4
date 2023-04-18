class_name Hurtbox
extends Area2D

signal hurt(hitbox, damage)

func take_hit(hitbox, damage):
	hurt.emit(hitbox, damage)
