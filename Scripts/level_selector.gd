extends Control

var secretLevelUnlock = false
@onready var SecretLevel = $SecretLevel

func _ready() -> void:
	if secretLevelUnlock:
		SecretLevel.Visible = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/main.tscn")


func _on_level_one_button_pressed() -> void:
	MenuMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/Levels/level_one.tscn")
	
