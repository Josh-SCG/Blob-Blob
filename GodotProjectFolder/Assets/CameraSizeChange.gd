extends Area2D


var cam

func _on_CameraSizeChange_body_entered(body):
	if "Player" in body.name:
		cam = body.get_node("Camera2D")
		cam.set_zoom(Vector2(1,1))
