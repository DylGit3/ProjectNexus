extends CharacterBody2D

var health = 4
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var looking = 1
var chase = false
var SPEED = 60.0
var is_attacking = false

func _physics_process(delta: float):
	velocity.y += gravity * delta
	
	if is_attacking == false:
		if chase:
			$AnimationPlayer.play("run")
			player = get_node("../../Player/Player")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = false
			else:
				get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED
		else:
			velocity.x = 0
			$AnimationPlayer.play("idle")
	
	
	move_and_slide()



func _on_player_detection_body_entered(body: Node2D):
	if body.name == "Player":
		chase = true
		print("yea")


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
