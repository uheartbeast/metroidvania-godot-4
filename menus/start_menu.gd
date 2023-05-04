extends ColorRect

func _ready():
	PlayerStats.reset()

func _on_start_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	get_tree().change_scene_to_file("res://world.tscn")

func _on_load_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	SaveManager.is_loading = true
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
