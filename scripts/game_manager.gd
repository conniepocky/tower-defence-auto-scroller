extends Node

var active_card_type = null

# Define your cards here
var card_database = {
	"oil": {
		"damage": 0,
		"status_effect": "oiled",
		"image": "res://images/cards/oil_card.png",
		"color": Color.BLACK
	},
	"fire": {
		"damage": 5, 
		"image": "res://images/cards/fire_card.png",
		"status_effect": "",
		"combo_trigger": "oiled", 
		"combo_damage": 25,      
		"color": Color.ORANGE
	},
	"water": {
		"damage": 2,
		"status_effect": "wet",
		"image": "res://images/cards/water_card.png",
		"color": Color.BLUE
	},
	"lightning": {
		"damage": 5,
		"image": "res://images/cards/lightning_card.png",
		"status_effect": "",
		"combo_trigger": "wet",
		"combo_damage": 20,
		"color": Color.YELLOW
	},
	"staff": {  
		"damage": 25,
		"status_effect": "",
		"image": "res://images/cards/staff_card.png",
		"color": Color.CYAN,
		"type": "projectile" 
	},
	"magic": {  
		"damage": 25,
		"status_effect": "",
		"image": "res://images/cards/magic_card.png",
		"color": Color.SKY_BLUE,
		"type": "projectile" 
	},
	"bubble": {
		"damage": 0,
		"status_effect": "",
		"image": "res://images/cards/bubble_card.png",
		"color": Color.HOT_PINK,
		"type": "bubble"
	}
}

func select_card(type):
	var player = get_tree().get_first_node_in_group("player")
	
	if type == "staff":
		if player:
			player.throw_staff()
	if type == "magic":
		if player:
			player.throw_magic()
			
	if type == "bubble":
		if player:
			player.activate_bubble()
	
	active_card_type = type
	
	var label = get_tree().get_first_node_in_group("card_label")
	
	if label:
		label.text = "Active Card: " + type.capitalize()
