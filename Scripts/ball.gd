extends CharacterBody2D

class_name Ball


signal life_lost

const VELOCITY_LIMIT = 40

@export var ball_speed = 250
@export var lives : int = 3


var speed_up_factor = 1.05

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var death_zone: DeathZone = $"../DeathZone"
@onready var ui: UI = $"../UI"

var start_position : Vector2

func _ready() -> void:
	ui.set_lives(lives)
	start_position = position
	death_zone.life_lost.connect(on_life_lost)

func _physics_process(delta):
	var collision = move_and_collide(velocity * ball_speed * delta)
	if !collision:
		return
	
	var collider = collision.get_collider()
	if collider is Brick:
		collider.decrease_level()
	
	velocity = velocity.bounce(collision.get_normal())

func start_ball():
	position = start_position
	randomize()
	
	velocity = Vector2(randf_range(-1,1), randf_range(-.1, -1)).normalized()
	

func on_life_lost():
	lives -= 1
	ui.set_lives(lives)
	if lives == 0:
		ui.game_over()
	
	else:
		life_lost.emit()
		reset_ball()
	

func reset_ball():
	position = start_position
	velocity = Vector2.ZERO
