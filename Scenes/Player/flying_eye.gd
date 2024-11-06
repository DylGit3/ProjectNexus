extends CharacterBody2D

var health = 2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var looking = 1
var chase = false
var SPEED = 60.0
var is_attacking = false
var in_battle = false

func _physics_process(delta: float):
	
	velocity.y += gravity * delta
	
	if health <= 0 and health >= -99:
		health = -100
		Game.gold += 1
		$AnimationPlayer.play("death")
		get_node("levitate").disabled = true
		get_node("deathLevitate").disabled = false
		get_node("realBody").disabled = true
		get_node("areabody").monitoring = false
		velocity.x = 0
		get_node("playerDetectionArea/playerDetection").disabled = true
		#get_node("realBodyArea").monitoring = false
		await get_node("AnimationPlayer").animation_finished
	elif health > 0:
		if is_attacking == false:
			if chase:
				$AnimationPlayer.play("fly")
				player = get_node("../../Player/Player")
				var direction = (player.position - self.position).normalized()
				if direction.x > 0:
					get_node("AnimatedSprite2D").flip_h = false
				else:
					get_node("AnimatedSprite2D").flip_h = true
				velocity.x = direction.x * SPEED
			else:
				velocity.x = 0
				$AnimationPlayer.play("fly")
		
	
	move_and_slide()


func _on_detection_area_body_entered(body: Node2D):
	if body.name == "Player":
		chase = true

func _on_detection_area_body_exited(body: Node2D):
	if body.name == "Player":
		chase = false


func _on_player_detection_area_body_entered(body: Node2D):
	if body.name == "Player":
		in_battle = true
		while in_battle:
			velocity.x = 0
			$AnimationPlayer.play("attack")
			is_attacking = true
			await get_node("AnimationPlayer").animation_finished
			is_attacking = false

func _on_player_detection_area_body_exited(body: Node2D):
	if body.name == "Player":
		in_battle = false

func _on_areabody_area_entered(area: Area2D):
	if area.is_in_group("playerDamage"):
		health -= Game.playerDMG
