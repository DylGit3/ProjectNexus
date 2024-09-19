extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().pause = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().pause = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused:
		resume()

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
	# pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
	# pass


func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta):
	testEsc()
