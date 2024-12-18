extends CharacterBody2D

var health = Game.playerHP
var gold = Game.gold
const JUMP_VELOCITY = -300.0

var speed = 150.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var cshape = $CollisionShape2D

var standing_shape = preload("res://Scenes/Player/stand_cshape.tres")
var crouching_shape = preload("res://Scenes/Player/crouch_cshape.tres")

var is_crouching = false
var direction_looking = 1

var is_attacking = false
var attack_first_blocked = false

var is_hurt = false

func _process(_delta):
	gold = Game.gold
	#if is_attacking == false and is_on_floor() and velocity.x > 0 and $StepSound.playing == false:
			#$StepSound.play()

func _physics_process(delta: float):
	# Add the gravity.
	if health <= 0:
		$AnimationPlayer.play("Death")
		await get_tree().create_timer(4).timeout
	else:
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

		if Input.is_action_just_pressed("attackFirst") and is_attacking == false:
			$SwordSound.play()
			$AnimationPlayer.play("AttackFirst")
			is_attacking = true
			velocity.x *= .33
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
				$Area2D/bodycollision.position.x = 1
			elif is_crouching and direction_looking == -1:
				cshape.position.x = 2.125
				$Area2D/bodycollision.position.x = cshape.position.x * 3
			elif !is_crouching and direction_looking == 1:
				cshape.position.x = -2.76
				$Area2D/bodycollision.position.x = 0
			elif !is_crouching and direction_looking == -1:
				cshape.position.x = 2.645
				$Area2D/bodycollision.position.x = cshape.position.x * 3
	
		if is_hurt == true:
			anim.play("Hurt")
			velocity.x = 0
			velocity.y = 0
			await get_tree().create_timer(0.4).timeout
			is_hurt = false
	
		move_and_slide()

func crouch():
	if is_crouching:
		return
	is_crouching = true
	speed = 100.0
	cshape.shape = crouching_shape
	cshape.position.x = -2.075
	cshape.position.y = -7
	$Area2D/bodycollision.shape = cshape.shape
	$Area2D/bodycollision.position.x = 0
	$Area2D/bodycollision.position.y = 3.5

func stand_from_crouch():
	if !is_crouching:
		return
	is_crouching = false
	speed = 150.0
	cshape.shape = standing_shape
	cshape.position.x = -2.765
	cshape.position.y = -9.715
	$Area2D/bodycollision.shape = cshape.shape
	$Area2D/bodycollision.position.x = 0
	$Area2D/bodycollision.position.y = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not is_hurt:
		if area.is_in_group("skeletonDamage"):
			health -= Game.skeletonDMG
			$HurtSound.play()
			is_hurt = true
		if area.is_in_group("mushroomDamage"):
			health -= Game.mushroomDMG
			$HurtSound.play()
			is_hurt = true
		if area.is_in_group("eyeDamage"):
			health -= Game.eyeDMG
			$HurtSound.play()
			is_hurt = true
		if area.is_in_group("reaperDamage"):
			health -= Game.reaperDMG
			$HurtSound.play()
			is_hurt = true
