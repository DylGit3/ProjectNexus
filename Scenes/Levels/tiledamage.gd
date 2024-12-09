extends Area2D


func _on_body_entered(body: PhysicsBody2D):
		print("entered")
		$"../Player/Player".health = 0
		await get_tree().create_timer(4).timeout
