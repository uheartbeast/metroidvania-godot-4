extends AnimatedSprite2D

func _ready():
	animation_finished.connect(queue_free)
