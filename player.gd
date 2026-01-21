extends CharacterBody2D

const SPEED = 5.0
const JUMP_VELOCITY = -200.0

var health = 10

var staff_scene = preload("res://staff.tscn")

func take_damage(amount):
	health -= amount
	update_health_ui()
	print("Ouch! Health is now: ", health)
	
	if health <= 0:
		die()

func die():
	print("Game Over!")
	get_tree().reload_current_scene()

func update_health_ui():
	%HealthLabel.text = "Health: " + str(health)

func _process(delta: float):
	velocity.x += SPEED * delta
	move_and_slide()

func throw_staff():
	print("throwing staff")
	var new_staff = staff_scene.instantiate()
	
	new_staff.position = position + Vector2(-25, 0)
	
	get_parent().add_child(new_staff)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.x = SPEED
	
	move_and_slide()
