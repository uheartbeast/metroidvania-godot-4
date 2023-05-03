extends Area2D

var is_active = true

signal trigger_entered

func _on_body_entered(body):
	if not is_active: return
	trigger_entered.emit()
