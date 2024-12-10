extends CharacterBody2D

var health = 7
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var looking = 1
var chase = false
var SPEED = 100.0
var is_attacking = false
var in_battle = false

func _physics_process(delta: float):
	if health <= 0 and health >= -99:
		health = -100
		Game.gold += 2
		$AnimationPlayer.play("death")
		await get_node("AnimationPlayer").animation_finished
		self.queue_free() 
	elif health > 0:
		velocity.y += gravity * delta
		if is_attacking == false:
			if chase:
				$AnimationPlayer.play("idle")
				player = get_node("../Player/Player")
				var direction = (player.position - self.position).normalized()
				if direction.x > 0:
					get_node("animatedsprite").flip_h = false
					$attackArea/attackCollision.position.x = 19
					$attackdetection/attackdetectionbox.position.x = 19
				else:
					get_node("animatedsprite").flip_h = true
					$attackArea/attackCollision.position.x = -19
					$attackdetection/attackdetectionbox.position.x = -19
				velocity.x = direction.x * SPEED
			else:
				velocity.x = 0
				$AnimationPlayer.play("idle")
		
		
		move_and_slide()

func _on_detectionarea_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_detectionarea_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_attackdetection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_battle = true
		while in_battle:
			velocity.x = 0
			#$AttackSound.play()
			$AnimationPlayer.play("attack")
			is_attacking = true
			await get_node("AnimationPlayer").animation_finished
			is_attacking = false


func _on_attackdetection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_battle = false


func _on_areabody_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerDamage"):
		print(health)
		health -= Game.playerDMG
