extends HBoxContainer

var deck = ["oil", "staff", "fire", "water", "lightning"]

func _ready():
	for button in get_children():
		button.pressed.connect(_on_card_pressed.bind(button))
		_reload_card(button) 

func _on_card_pressed(button):
	var type = button.text.to_lower()
	GameManager.select_card(type)
	
	print("Armed with: ", type)
	
	button.disabled = true
	button.text = "..."
	
	await get_tree().create_timer(1.5).timeout
	
	_reload_card(button)

func _reload_card(button):
	var new_card = deck.pick_random()
	button.text = new_card.capitalize()
	button.disabled = false

	button.modulate = GameManager.card_database[new_card]["color"]
