extends Node2D

# CONFIGURATION
var sequence = []       
var current_index = 0  
var length = 3          

# SIGNALS
signal puzzle_solved   
signal puzzle_failed    

@onready var arrow_container = $CanvasLayer/ColorRect/CenterContainer/VBoxContainer/ArrowRow

@onready var ui_layer = $CanvasLayer 

func start_puzzle():
	ui_layer.visible = true  
	get_tree().paused = true
	generate_sequence()

func close():
	ui_layer.visible = false 
	get_tree().paused = false

func generate_sequence():
	print("generating")
	for child in arrow_container.get_children():
		child.queue_free()
	
	sequence.clear()
	current_index = 0
	
	var options = ["ui_up", "ui_down", "ui_left", "ui_right"]
	
	for i in range(length):
		var random_action = options.pick_random()
		sequence.append(random_action)
		add_arrow_icon(random_action)
		
	print(sequence)

func add_arrow_icon(action_name):
	var icon = TextureRect.new() 
	
	if action_name == "ui_up": icon.texture = load("res://arrows/up.png")
	elif action_name == "ui_down": icon.texture = load("res://arrows/down.png")
	elif action_name == "ui_left": icon.texture = load("res://arrows/left.png")
	elif action_name == "ui_right": icon.texture = load("res://arrows/right.png")
	
	# resize + texture filters to look nice
	
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.custom_minimum_size = Vector2(8, 8)
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	icon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

	arrow_container.add_child(icon)

func _input(event):
	if not ui_layer.visible: return 
	
	if event is InputEventKey and event.pressed:
		check_input(event)

func check_input(event):
	if sequence.size() == 0:
		return
		
	print("pressed key")
	
	if event.is_action_pressed(sequence[current_index]):
		var icon = arrow_container.get_child(current_index)
		icon.modulate = Color.GREEN 
		current_index += 1
		
		if current_index >= sequence.size():
			win()
	else:
		print("fail")
		fail()

func win():
	print("Puzzle Solved!")
	puzzle_solved.emit() 
	close()

func fail():
	puzzle_failed.emit()
	close()
