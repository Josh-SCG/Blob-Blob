extends Node2D


onready var enemies =  get_parent().get_node("Enemies") # Replace with function body.
onready var player_points = get_parent().get_node("Player").points

func _physics_process(delta):
	if enemies.get_child_count() == player_points:
		queue_free()
