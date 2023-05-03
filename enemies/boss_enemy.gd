extends Node2D

const StingerScene = preload("res://enemies/stinger.tscn")
const MissilePowerupScene = preload("res://player/missile_powerup.tscn")
const EnemyDeathEffectSceen = preload("res://effects/enemy_death_effect.tscn")

@export var acceleration = 200
@export var max_speed = 800
@export var targets : Array[NodePath]

var state = recenter_state : set = set_state
var state_init = true : get = get_state_init
var velocity = Vector2.ZERO

var STATE_OPTIONS = [fire_state, fire_state, rush_state, rush_state]
var state_options_left = []

@onready var stats = $Stats
@onready var stinger_pivot = $StingerPivot
@onready var muzzle = $StingerPivot/Muzzle
@onready var firerate_timer = $FirerateTimer
@onready var state_timer = $StateTimer

func set_state(value):
	state = value
	state_init = true

func get_state_init():
	var was = state_init
	state_init = false
	return was

func _ready():
	var freed = WorldStash.retrieve("first_boss", "freed")
	if freed: queue_free()

func _process(delta):
	state.call(delta)

func rush_state(delta):
	if state_init:
		state_timer.start(randf_range(4.0, 6.0))
		state_timer.timeout.connect(set_state.bind(decelertate_state), CONNECT_ONE_SHOT)
	var player = MainInstances.player
	if not player is Player: return
	var direction = global_position.direction_to(player.global_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	move(delta)

func fire_state(delta):
	if state_init:
		state_timer.start(randf_range(4.0, 6.0))
		state_timer.timeout.connect(set_state.bind(recenter_state), CONNECT_ONE_SHOT)
	if firerate_timer.time_left == 0:
		stinger_pivot.rotation_degrees += 17
		firerate_timer.start()
		var stinger = Utils.instantiate_scene_on_world(StingerScene, muzzle.global_position)
		stinger.rotation = stinger_pivot.rotation
		stinger.update_velocity()

func recenter_state(delta):
	assert(not targets.is_empty())
	if state_init:
		var center_node = get_node(targets.pick_random())
		var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "global_position", center_node.global_position, 2.0)
		await tween.finished
		state_timer.start(0.5)
		await state_timer.timeout
		if state_options_left.is_empty():
			state_options_left = STATE_OPTIONS.duplicate()
			state_options_left.shuffle()
		state = state_options_left.pop_back()

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
	WorldStash.stash("first_boss", "freed", true)
	Utils.instantiate_scene_on_world(MissilePowerupScene, global_position)
	for i in 6:
		Utils.instantiate_scene_on_world(EnemyDeathEffectSceen, global_position+Vector2(randf_range(-16, 16), randf_range(-16, 16)))
