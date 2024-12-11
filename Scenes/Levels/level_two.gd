extends Node2D

func _process(delta: float) -> void:
	if get_node("Player/Player").health <= 0:
		await get_tree().create_timer(1.5).timeout
		$canvaslayer2/death_menu.visible = true
<<<<<<< HEAD
	
=======
>>>>>>> 00efadc2cf66d899d74fc5c9eeb168f19e260e7a
