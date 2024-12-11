extends Node2D

func _ready():
	Game.playerHP = 10

func _process(delta: float) -> void:
	if get_node("Player/Player").health <= 0:
		await get_tree().create_timer(1.5).timeout
		$canvaslayer2/death_menu.visible = true
