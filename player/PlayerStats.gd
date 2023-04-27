extends Stats

@export var max_missiles = 3 : set = set_max_missiles

@onready var missiles = 3 : set = set_missiles

func set_max_missiles(value):
	max_missiles = value

func set_missiles(value):
	missiles = clampi(value, 0, max_missiles)
