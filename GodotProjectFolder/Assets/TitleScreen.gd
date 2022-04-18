extends Node

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Start.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()
	
	if $MarginContainer/VBoxContainer/VBoxContainer/Exit.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/Exit.grab_focus()


func _on_Start_pressed():
	get_tree().change_scene("Test.tscn")


func _on_Exit_pressed():
	get_tree().quit()
