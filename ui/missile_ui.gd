extends HBoxContainer

@onready var label = $Label

func _ready():
	_max_missiles_changed()
	update_missile_label()
	PlayerStats.missiles_changed.connect(update_missile_label)
	PlayerStats.max_missiles_changed.connect(_max_missiles_changed)

func update_missile_label():
	label.text = str(PlayerStats.missiles)

func _max_missiles_changed():
	visible = PlayerStats.max_missiles > 0
