extends HBoxContainer

var deck = ["oil", "staff", "fire", "water", "lightning", "bubble"]

func _ready():
	for card in get_children():
		card.pressed.connect(_on_card_pressed.bind(card))
		_reload_card(card) 

func _on_card_pressed(card):
	var type = card.get_meta("type")
	
	GameManager.select_card(type)

	card.disabled = true
	
	card.texture_normal = load("res://images/cards/card.png") 
	
	await get_tree().create_timer(1.5).timeout
	
	_reload_card(card)

func _reload_card(card):
	var player = get_tree().get_first_node_in_group("player")
	var new_card = deck.pick_random()
	
	if player and "bubble_active" in player:
		var retries = 0
		while new_card == "bubble" and player.bubble_active and retries < 10: # prevent infinite loop
			new_card = deck.pick_random()
			retries += 1
	
	card.set_meta("type", new_card)
	
	var image_path = GameManager.card_database[new_card]["image"]
	card.texture_normal = load(image_path)
	
	card.disabled = false
