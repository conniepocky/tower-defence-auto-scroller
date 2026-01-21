extends Area2D

var speed = 100    

func _process(delta):
	position.y = -40
	position.x += speed * delta

func _on_body_entered(body):
	print(body.name)
	if body.is_in_group("enemy"):
		print("enemy")
		if body.has_method("take_damage"):
			body.take_damage()
		
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
