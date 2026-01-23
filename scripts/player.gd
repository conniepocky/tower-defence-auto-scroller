extends CharacterBody2D

const SPEED = 5.0
const JUMP_VELOCITY = -200.0

var health = 10

var staff_scene = preload("res://staff.tscn")

@export var puzzle : Node2D
@onready var bubble_sprite = $BubbleSprite

var bubble_active = false

func activate_bubble():
	bubble_active = true
	bubble_sprite.visible = true

func pop_bubble():
	get_node("../BubbleSFX").play()
	bubble_sprite.visible = false
	bubble_active = false

func show_icon():
	var hurt_icon = %HurtIcon
	
	hurt_icon.visible = true
	hurt_icon.modulate.a = 1.0
	
	var tween = create_tween()
	
	tween.tween_interval(0.2)
	
	tween.tween_property(hurt_icon, "modulate:a", 0.0, 0.5)
	
	tween.tween_callback(hurt_icon.hide)
	
func heal():
	print(health)
	health += 1
	print(health)
	update_health_ui()

func take_damage(amount):
	if bubble_active:
		pop_bubble()
		return
	
	health -= amount
	update_health_ui()
	
	show_icon()
	
	get_node("../PlayerHurtSFX").play()
	
	if health <= 0:
		die()

func die():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	game_over_screen.visible = true
	get_tree().paused = true
	
func update_health_ui():
	%HealthLabel.text = "Health: " + str(health)

func throw_staff():
	print("throwing staff")
	var new_staff = staff_scene.instantiate()
	
	new_staff.position = position + Vector2(-115, 0)
	
	get_parent().add_child(new_staff)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.x = SPEED
	
	move_and_slide()

# code for game over and start screen + initial setup

@onready var game_over_screen = $"../GameOverLayer/GameOverScreen"
@onready var start_screen = $"../StartLayer/StartScreen"

func _ready():
	game_over_screen.visible = false
	start_screen.visible = true
	
	get_tree().paused = true
	
func start_game():
	start_screen.visible = false
	get_tree().paused = false
	
# try again button on game over screen
	
func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
# autoscrolling and start screen setup
	
func _process(delta):	
	if start_screen.visible:
		if Input.is_action_just_pressed("ui_accept"): # spacebar
			start_screen.visible = false
			get_tree().paused = false
	
	if not get_tree().paused:
		velocity.x += SPEED * delta
		move_and_slide()
