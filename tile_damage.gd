extends Area2D


func _on_body_entered(body: PhysicsBody2D):
		print("entered")
		$"../Player/Player".health = $"../Player/Player".health - 1
		
