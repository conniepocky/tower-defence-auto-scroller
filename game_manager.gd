extends Node

var active_card_type = null

# Define your cards here
var card_database = {
	"oil": {
		"damage": 0,
		"status_effect": "oiled",
		"color": Color.BLACK
	},
	"fire": {
		"damage": 5, 
		"status_effect": "burn",
		"combo_trigger": "oiled", 
		"combo_damage": 25,      
		"color": Color.ORANGE
	},
	"water": {
		"damage": 2,
		"status_effect": "wet",
		"color": Color.BLUE
	},
	"lightning": {
		"damage": 5,
		"status_effect": "shock",
		"combo_trigger": "wet",
		"combo_damage": 20,
		"color": Color.YELLOW
	}
}

func select_card(type):
	active_card_type = type
