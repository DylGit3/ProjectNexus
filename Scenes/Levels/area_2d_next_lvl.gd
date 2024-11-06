extends Area2D


var entered = false

func _on_body_entered(body: PhysicsBody2D):
	print ("Entered Area")
	entered = true

func _on_body_exited(body: Node2D):
	print ("Exited Area")
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			print("Changing lvl")
			get_tree().change_scene_to_file("res://Scenes/Levels/level_one.tscn")
