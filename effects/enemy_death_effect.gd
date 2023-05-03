extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Sound.play(Sound.enemy_die)
