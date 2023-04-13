extends CharacterBody2D

@export var acceleration = 512
@export var max_velocity = 64
@export var friction = 256
@export var gravity = 200
@export var jump_force = 128
@export var max_fall_velocity = 128

func _physics_process(delta):
	apply_gravity(delta)
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if is_moving(input_axis):
		apply_acceleration(delta, input_axis)
	else:
		apply_friction(delta)
	jump_check()
	move_and_slide()

func is_moving(input_axis):
	return input_axis != 0

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta)

func apply_acceleration(delta, input_axis):
	if is_moving(input_axis):
		velocity.x = move_toward(velocity.x, input_axis * max_velocity, acceleration * delta)

func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, friction * delta)

func jump_check():
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
