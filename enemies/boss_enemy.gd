extends Node2D

const StingerScene = preload("res://enemies/stinger.tscn")

@export var acceleration = 200
@export var max_speed = 800
@export var targets : Array[NodePath]

var state = rush_state
var velocity = Vector2.ZERO

@onready var stats = $Stats
@onready var stinger_pivot = $StingerPivot
@onready var muzzle = $StingerPivot/Muzzle
@onready var firerate_timer = $FirerateTimer
@onready var state_timer = $StateTimer

func _process(delta):
	state.call(delta)

func rush_state(delta):
	var player = MainInstances.player
	if not player is Player: return
	var direction = global_position.direction_to(player.global_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	move(delta)

func fire_state(delta):
	if firerate_timer.time_left == 0:
		stinger_pivot.rotation_degrees += 17
		firerate_timer.start()
		var stinger = Utils.instantiate_scene_on_world(StingerScene, muzzle.global_position)
		stinger.rotation = stinger_pivot.rotation
		stinger.update_velocity()

func recenter_state(delta):
	assert(not targets.is_empty())
	set_process(false)
	var center_node = get_node(targets.pick_random())
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", center_node.global_position, 2.0)
	await tween.finished
	set_process(true)
	state = rush_state

func decelertate_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	move(delta)
	if velocity == Vector2.ZERO:
		state = recenter_state

func move(delta):
	translate(velocity * delta)

func _on_hurtbox_hurt(hitbox, damage):
	stats.health -= damage

func _on_stats_no_health():
	queue_free()

func _on_state_timer_timeout():
	state = decelertate_state
