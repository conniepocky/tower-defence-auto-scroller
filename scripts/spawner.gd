extends Marker2D

var enemy_scene = preload("res://Enemy.tscn")
var healer_scene = preload("res://healer.tscn")
var healer_spawn_interval = 18.0
var enemy_spawn_interval = 2.0

func _ready():
	spawning_loop(enemy_spawn_interval, _spawn_enemy, true)
	spawning_loop(healer_spawn_interval, _spawn_healer, false)
	
func spawning_loop(interval, method, is_random):
	var timer = Timer.new()
	add_child(timer)

	timer.timeout.connect(func():
		method.call() 
		
		if is_random:
			timer.wait_time = randf_range(1.25, 2.5)
	)
	
	timer.wait_time = interval
	timer.start()

func _spawn_healer():
	var new_healer = healer_scene.instantiate()
	
	new_healer.position = position
	
	get_parent().add_child(new_healer)

func _spawn_enemy():
	var new_enemy = enemy_scene.instantiate()
	
	new_enemy.position = position
	
	get_parent().add_child(new_enemy)
