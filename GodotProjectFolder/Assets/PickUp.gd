extends Area2D

func _on_PickUp_body_entered(body):
	if "Player" in body.name:
		body.points += 1
	queue_free()
