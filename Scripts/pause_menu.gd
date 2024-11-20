extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	print("Resuming the game")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	print("Pausing the game")

func testEsc():
	if Input.is_action_just_pressed("Escape"):  # Ensure "escape" is correct in the Input Map
		if get_tree().paused:
			print("Escape pressed - game is paused, resuming...")
			resume()
		else:
			print("Escape pressed - game is not paused, pausing...")
			pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	testEsc()

func _on_resume_pressed() -> void:
	resume()
	
func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
	

func _on_quit_pressed() -> void:
	resume()
	MenuMusic.play_music_menu()
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")
