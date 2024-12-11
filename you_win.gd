extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuMusic.play_music_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$ClickSound.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")
