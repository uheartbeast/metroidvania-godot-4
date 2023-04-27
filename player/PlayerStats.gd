extends Stats

@export var max_missiles = 0 : set = set_max_missiles

@onready var missiles = max_missiles : set = set_missiles

signal max_missiles_changed
signal missiles_changed

func set_max_missiles(value):
	max_missiles = value
	max_missiles_changed.emit()

func set_missiles(value):
	missiles = clampi(value, 0, max_missiles)
	missiles_changed.emit()
