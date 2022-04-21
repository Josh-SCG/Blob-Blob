extends KinematicBody2D

const UP = Vector2(0,-1) #Essentially down/floor
const GRAVITY =  20

const PICK_UP = preload("res://PickUp.tscn")

export (int) var speed = 40
export (int) var health = 1
export (Vector2) var size = Vector2(1,1)
var motion = Vector2()
var direction = 1 #left
var is_dead = false

func _ready():
	self.scale = size

func dead():
	health -= 1
	if health ==0:
		is_dead = true
		motion = Vector2.ZERO
		$AnimationPlayer.playback_speed = 4
		$CollisionPolygon2D.set_deferred("disabled", true)
		$Timer.start()
		if self.scale > Vector2(1,1):
			get_parent().get_node("ScreenShake").screenShake(1,float(size.x+size.y)/2,100)

func _physics_process(delta):
	if is_dead == false:
		motion.x = speed * direction
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
			
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()


func _on_Timer_timeout():
	var pickUp = PICK_UP.instance()
	pickUp.global_position = global_position
	get_tree().get_root().add_child(pickUp)
	queue_free()
