extends ColorRect

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_load_button_pressed():
	print("load save game")
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit()
