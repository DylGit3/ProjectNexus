extends Area2D


var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true


func _on_body_exited(body: Node2D):
	entered = false

func show_you_win_screen():
	var you_win_screen = load("res://Scenes/Menu/you_win.tscn").instantiate()
	get_tree().root.add_child(you_win_screen)


func _process(delta):
	if entered == true:
		Game.playerHP = 5
		if Input.is_action_just_pressed("ui_accept"):
			show_you_win_screen()
