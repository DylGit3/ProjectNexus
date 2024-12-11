extends Control

var secretLevelUnlock = false

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	if Game.levelOneComplete:
		$LevelTwoButton.disabled = false
		
	if Game.levelTwoComplete:
		$LevelThreeButton.disabled = false

func _on_level_one_button_pressed() -> void:
	$ClickSound.play()
	await get_tree().create_timer(1).timeout
	MenuMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/Levels/level_one.tscn")

func _on_level_two_button_pressed() -> void:
	$ClickSound.play()
	await get_tree().create_timer(1).timeout
	MenuMusic.stop()
	get_tree().change_scene_to_file("res://Scenes/Levels/level_two.tscn")


func _on_level_three_button_pressed() -> void:
	$ClickSound.play()
	await get_tree().create_timer(1).timeout
	MenuMusic.stop()
	get_tree().change_scene_to_file("res://levelthree.tscn")


func _on_back_button_pressed() -> void:
	$ClickSound.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/main.tscn")
