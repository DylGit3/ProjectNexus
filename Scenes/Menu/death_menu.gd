extends Control


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	MenuMusic.play_music_menu()
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")
