extends Node2D
func _ready() -> void:
	MenuMusic.play_music_menu()

func _on_button_pressed() -> void:
	$ClickSound.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")
