extends CharacterBody2D

var health = 3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var looking = 1
var chase = false
var SPEED = 125.0
var is_attacking = false

func _physics_process(delta: float):
	if health <= 0 and health >= -99:
		health = -100
		Game.gold += 1
		$AnimationPlayer.play("death")
		get_node("body").disabled = true
		get_node("PlayerDetection").monitoring = false
		get_node("attackarea").monitoring = false
		await get_node("AnimationPlayer").animation_finished
		$hurtbox/hurtbox.disabled = true
	elif health > 0:
		velocity.y += gravity * delta
		
		if is_attacking == false:
			if chase == true:
				$AnimationPlayer.play("walk")
				player = get_node("../../Player/Player")
				var direction = (player.position - self.position).normalized()
				if get_node("AnimatedSprite2D").offset.x != 0:
						get_node("AnimatedSprite2D").offset.x += 17
				if direction.x > 0:
					looking = 1
					get_node("AnimatedSprite2D").flip_h = false
					get_node("attackarea").position.x = 17
					get_node("body").position.x = -2
					get_node("areabody/areacollision").position.x = -2
					get_node("hurtbox").position.x = 0
				else:
					looking = -1
					get_node("AnimatedSprite2D").flip_h = true
					get_node("attackarea").position.x = 5
					get_node("body").position.x = 2
					get_node("areabody/areacollision").position.x = 2
					get_node("hurtbox").position.x = -14
				velocity.x = direction.x * SPEED
			else:
				if get_node("AnimatedSprite2D").animation != "death":
					$AnimationPlayer.play("idle")
				velocity.x = 0
			
				
		move_and_slide()
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false

func _on_attackarea_body_entered(body: Node2D):
	if body.name == "Player":
		velocity.x = .33
		$AnimationPlayer.play("attack")
		if looking == -1:
			get_node("AnimatedSprite2D").offset.x -= 17
		is_attacking = true
		await get_node("AnimationPlayer").animation_finished
		is_attacking = false


func _on_areabody_area_entered(area: Area2D):
	if area.is_in_group("playerDamage"):
		health -= Game.playerDMG

# keep attacking if player is in range
