extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	MenuMusic.play_music_menu()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/options.tscn")

func _on_Quit_pressed() -> void:
	get_tree().quit()
