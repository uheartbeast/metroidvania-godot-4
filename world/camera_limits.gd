extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.camera_limits_changed.emit(
		position.x,
		position.x + size.x,
		position.y,
		position.y + size.y,
	)
	hide()
