extends CharacterBody2D

var health = 3
const JUMP_VELOCITY = -400.0

var speed = 150.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var cshape = $CollisionShape2D

var standing_shape = preload("res://Scenes/Player/stand_cshape.tres")
var crouching_shape = preload("res://Scenes/Player/crouch_cshape.tres")

var is_crouching = false
var direction_looking = 1

var is_attacking = false


func _process(_delta):
	return

func _physics_process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction == 1:
		direction_looking = 1
	elif direction == -1:
		direction_looking = -1
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
		get_node("hitbox1").position.x = -32
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		get_node("hitbox1").position.x = 0

	if Input.is_action_just_pressed("attackFirst"):
		$AnimationPlayer.play("AttackFirst")
		is_attacking = true
		velocity.x *= .25
		await get_tree().create_timer(0.4).timeout
		is_attacking = false

	# Handle jump.
	if is_attacking == false:
		if Input.is_action_just_pressed("move_up") and is_on_floor() and is_crouching:
			velocity.y = JUMP_VELOCITY
			anim.play("Crouch")
		elif Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim.play("Jump")
			
		# Handle crouch
		if Input.is_action_just_pressed("crouch") and is_on_floor():
			anim.play("Crouch")

		if Input.is_action_just_pressed("crouch"):
			crouch()
		elif Input.is_action_just_released("crouch"):
			stand_from_crouch()

		if direction:
			velocity.x = direction * speed
			if velocity.y == 0:
				if is_crouching:
					anim.play("Crouch_Walk")
				else:
					anim.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			if is_crouching:
				anim.play("Crouch")
			else:
				anim.play("Idle")

		if velocity.y > 0 and is_crouching:
			anim.play("Crouch")
		elif velocity.y > 0:
			anim.play("Fall")
		
		if is_crouching and direction_looking == 1:
			cshape.position.x = -2.075
		elif is_crouching and direction_looking == -1:
			cshape.position.x = 2.125
		elif !is_crouching and direction_looking == 1:
			cshape.position.x = -2.765
		elif !is_crouching and direction_looking == -1:
			cshape.position.x = 2.645
	
	move_and_slide()

func crouch():
	if is_crouching:
		return
	is_crouching = true
	speed = 100.0
	cshape.shape = crouching_shape
	cshape.position.x = -2.075
	cshape.position.y = -7

func stand_from_crouch():
	if !is_crouching:
		return
	is_crouching = false
	speed = 150.0
	cshape.shape = standing_shape
	cshape.position.x = -2.765
	cshape.position.y = -9.715
