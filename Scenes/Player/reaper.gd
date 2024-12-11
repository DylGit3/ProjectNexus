extends CharacterBody2D

var health = 7
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var looking = 1
var chase = false
var SPEED = 125.0
var is_attacking = false
var in_battle = false

func _physics_process(delta: float):
	if health <= 0 and health >= -99:
		health = -100:
			
	elif health > 0:
		velocity.y += gravity * delta
		
		
		
		move_and_slide()

func _on_detectionarea_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_detectionarea_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
