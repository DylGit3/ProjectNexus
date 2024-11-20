extends Area2D


var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true

func _on_body_exited(body: Node2D):
	entered = false
	
func _process(delta):
	if entered == true:
		Game.playerHP = 5
		if Input.is_action_just_pressed("ui_accept"):
			Game.levelOneComplete = true
			get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")
