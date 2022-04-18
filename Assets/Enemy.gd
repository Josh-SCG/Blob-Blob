extends KinematicBody2D

const UP = Vector2(0,-1) #Essentially down/floor
const GRAVITY =  20
const MAX_SPEED = 40

var motion = Vector2()

var direction = 1 #left


func _physics_process(delta):
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
	
