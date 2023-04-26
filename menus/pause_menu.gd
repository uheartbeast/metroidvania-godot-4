extends ColorRect

var paused = false :
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		paused = !paused

func _on_resume_button_pressed():
	paused = false

func _on_quit_button_pressed():
	get_tree().quit()
