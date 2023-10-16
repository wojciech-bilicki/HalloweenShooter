extends Area2D

class_name Player

@onready var collision_shape_2d = $CollisionShape2D as CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D


@export var speed = 300
var direction = Vector2.ZERO

func _ready():
	animated_sprite_2d.play("wolfie_default")


func _physics_process(delta):
	
	var next_position = position + direction * speed * delta
	if !is_within_screen_bounds(next_position):
		return
	position = next_position
	

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO

func is_within_screen_bounds(next_position: Vector2):
	var half_size = collision_shape_2d.shape.get_rect().size / 2
	
	var viewport_size = get_viewport_rect().size
	
	if next_position.y > half_size.y && next_position.y + half_size.y < viewport_size.y && next_position.x > half_size.x && next_position.x + half_size.x < viewport_size.x:
		return true
	
	return false

func shoot():
	animated_sprite_2d.play("wolfie_shooting")


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "wolfie_shooting":
		animated_sprite_2d.play("wolfie_default")
