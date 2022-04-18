extends KinematicBody2D

const UP = Vector2(0,-1) #Essentially down/floor
const GRAVITY =  20
const MAX_SPEED = 40

const PICK_UP = preload("res://PickUp.tscn")

var motion = Vector2()
var direction = 1 #left
var is_dead = false

func dead():
	is_dead = true
	motion = Vector2.ZERO
	$AnimationPlayer.playback_speed = 4
	$CollisionPolygon2D.set_deferred("disabled", true)
	$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		motion.x = MAX_SPEED * direction
		motion.y += GRAVITY
		
		$AnimationPlayer.play("OnlyOne")
		
		motion = move_and_slide(motion, UP)
		
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		
		if is_on_wall():
			direction *= -1
			$RayCast2D.position.x *= -1
		
		if $RayCast2D.is_colliding() == false:
			direction *= -1
			$RayCast2D.position.x *= -1


func _on_Timer_timeout():
	var pickUp = PICK_UP.instance()
	pickUp.global_position = global_position
	get_tree().get_root().add_child(pickUp)
	queue_free()
