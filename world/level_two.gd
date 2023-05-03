extends Node2D

@onready var bricks = $Bricks
@onready var trigger = $Trigger
@onready var brick_3 = $Bricks/Brick3
@onready var brick_4 = $Bricks/Brick4

func _on_trigger_trigger_entered():
	var boss_freed = WorldStash.retrieve("first_boss", "freed")
	if not boss_freed:
		bricks.show()
		trigger.is_active = false

func _on_boss_enemy_tree_exited():
	brick_3.queue_free()
	brick_4.queue_free()
