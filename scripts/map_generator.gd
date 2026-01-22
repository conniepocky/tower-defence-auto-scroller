extends TileMapLayer

var chunk_width = 30           
var floor_y = 5               
var source_id = 1             
var atlas_coords = Vector2i(0,3)

var next_chunk_x = -20        
@onready var player = $"../Player" 

func _ready():
	for i in range(3):
		generate_chunk()

func _process(delta):
	var player_tile_pos = local_to_map(player.position) 
	
	if player_tile_pos.x > next_chunk_x - chunk_width:
		generate_chunk()

func generate_chunk():
	print("generating new ground at: ", next_chunk_x)
	
	for x in range(next_chunk_x, next_chunk_x + chunk_width):
		set_cell(Vector2i(x, floor_y), source_id, atlas_coords)
			
	next_chunk_x += chunk_width
