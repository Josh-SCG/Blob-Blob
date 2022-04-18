extends KinematicBody2D


const UP = Vector2(0,-1) #Essentially down/floor
const GRAVITY =  20 
const MAX_FALL_SPEED = 200
const MAX_SPEED = 80
const ACCELERATION = 8
const JUMP_FORCE = 300

const SLIME_BALL = preload("res://SlimeBall.tscn")

var motion = Vector2()
var facing_right = true
var is_attacking = false
var is_jumping = false

var points = 0

func _ready():
	pass

#The frame-by-frame processes
func _physics_process(delta):
	movement()
	shootSlimeBall()
	
#Function for playe rmovement
func movement():
	motion.y += GRAVITY #Always pushes player down
	if motion.y > MAX_FALL_SPEED: #Clamp the max fall speed
		motion.y = MAX_FALL_SPEED
	
	if is_jumping && motion.y >= 0:
		is_jumping = false
	
	if facing_right:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1
	
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	if Input.is_action_pressed("right"):
		if is_attacking == false || is_on_floor() == false:
			motion.x += ACCELERATION
			if is_attacking == false:
				facing_right = true
				$AnimationPlayer.play("Run")
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
	
	elif Input.is_action_pressed("left"):
		if is_attacking == false || is_on_floor() == false:
			motion.x -= ACCELERATION
			if is_attacking == false:
				facing_right = false
				$AnimationPlayer.play("Run")
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
	else:
		if is_attacking == false && is_on_floor():
			motion.x = lerp(motion.x,0,0.2)
			$AnimationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			if is_attacking == false:
				is_jumping = true
				motion.y = -JUMP_FORCE
		if Input.is_action_pressed("drop"):
			set_collision_mask_bit(1,false)
		
	if !is_on_floor():
		if is_attacking == false:
			if motion.y < 0:
				$AnimationPlayer.play("Jump")
			elif motion.y > 0:
				$AnimationPlayer.play("Falling")
	
	motion = move_and_slide(motion,UP)

func shootSlimeBall():
	if Input.is_action_just_pressed("fire") && is_attacking == false:
		if is_on_floor():
			motion.x = 0
		is_attacking = true
		$AnimationPlayer.play("Attack")
		var slimeBall = SLIME_BALL.instance()
		
		if sign($Position2D.position.x) == 1:
			slimeBall.setSlimeBallDirection(1)
		else:
			slimeBall.setSlimeBallDirection(-1)
		
		get_parent().add_child(slimeBall)
		slimeBall.position = $Position2D.global_position


func _on_AnimationPlayer_animation_finished(anim_name):
	is_attacking = false


func _on_Area2D_body_exited(body):
	set_collision_mask_bit(1, true)
	#For drop down to work, player collision mask needs to be 1+2, platform layer+mask 2 and functions here
