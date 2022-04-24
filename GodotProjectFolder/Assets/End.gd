extends Node2D


func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://TitleScreen.tscn")
