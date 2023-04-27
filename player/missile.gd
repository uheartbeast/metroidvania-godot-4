extends Projectile

func _on_hitbox_body_entered(body):
	super(body)
	if body is Brick:
		body.queue_free()
