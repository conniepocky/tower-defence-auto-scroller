extends Marker2D

var enemy_scene = preload("res://Enemy.tscn")

func _ready():
	var timer = Timer.new()
	timer.wait_time = 2.0 # spawn every 2 seconds
	timer.autostart = true
	timer.timeout.connect(_spawn_enemy)
	add_child(timer)

func _spawn_enemy():
	var new_enemy = enemy_scene.instantiate()
	
	new_enemy.position = position
	
	get_parent().add_child(new_enemy)
