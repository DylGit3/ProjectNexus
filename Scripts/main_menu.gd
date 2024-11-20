extends Control

const clickSound = preload("res://Assets/Audio/Retro1.ogg")
# Called when the node enters the scene tree for the first time.
func _ready():
	#Utility.saveGame()
	Utility.loadGame()
	MenuMusic.play_music_menu()

func _on_start_pressed() -> void:
	$ClickSound.play()
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selector.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/options.tscn")

func _on_Quit_pressed() -> void:
	get_tree().quit()
