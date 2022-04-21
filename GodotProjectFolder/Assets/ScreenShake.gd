extends Node2D

var current_shake_priority = 0


func _ready():
	pass # Replace with function body.

func moveCamera(vector):
	get_parent().get_node("Player").get_node("Camera2D").offset = Vector2(rand_range(-vector.x, vector.x),rand_range(-vector.y,vector.y))

func screenShake(shakeLength, shakePower, shakePriority):
	if shakePriority > current_shake_priority:
		current_shake_priority = shakePriority
		$Tween.interpolate_method(self, "moveCamera",Vector2(shakePower, shakePower),Vector2.ZERO, shakeLength, Tween.TRANS_SINE, Tween.EASE_OUT,0)
		$Tween.start()


func _on_Tween_tween_completed(object, key):
	current_shake_priority = 0
