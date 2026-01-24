extends CharacterBody2D

var speed = 50
var health = 15

var current_status = "" 

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = -speed
	move_and_slide()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if GameManager.active_card_type == "staff":
		return
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		take_damage()

func _on_area_2d_body_entered(body):
	print("entered body " + body.name)
	if body.is_in_group("player"):
		print("entered player")
		body.take_damage(1)
		
		queue_free()

func take_damage():
	var type = GameManager.active_card_type
	if type == null: return 
	
	var stats = GameManager.card_database[type]
	var final_damage = stats["damage"]
	
	get_node("../EnemyHurtSFX").play()
	
	if "combo_trigger" in stats: 
		print(type)
		print(current_status)
		if current_status == stats["combo_trigger"]:
			final_damage = stats["combo_damage"]
						
			current_status = "" 
			modulate = Color.WHITE

	if stats["status_effect"] != "":
		current_status = stats["status_effect"]
		_update_status_visuals()
	
	health -= final_damage
	
	if health <= 0:
		queue_free()
		
	GameManager.active_card_type = null
	
	var label = get_tree().get_first_node_in_group("card_label")
	
	if label:
		label.text = "Active Card: None"

func _update_status_visuals():
	if current_status == "oiled":
		modulate = Color.DIM_GRAY
	elif current_status == "wet":
		modulate = Color.CYAN
