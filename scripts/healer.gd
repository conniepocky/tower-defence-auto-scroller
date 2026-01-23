extends CharacterBody2D

var speed = 50
var is_active = true

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = -speed
	move_and_slide()
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		
		if not is_active: return # prevent double clicking
		is_active = false
		
		trigger_puzzle()

func trigger_puzzle():
	var puzzle_node = get_tree().get_first_node_in_group("puzzle")
	var player = get_tree().get_first_node_in_group("player") 

	if puzzle_node and player:
		if not puzzle_node.puzzle_solved.is_connected(player.heal):
			puzzle_node.puzzle_solved.connect(player.heal)
		
		puzzle_node.start_puzzle()
		
		queue_free()
	else:
		print("error: could not find player or puzzle")
