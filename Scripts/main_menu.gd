extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	MenuMusic.play_music_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	MenuMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/Global/level_selector.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Global/options.tscn")

func _on_Quit_pressed() -> void:
	get_tree().quit()
