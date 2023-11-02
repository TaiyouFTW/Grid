extends CharacterBody2D

@export var speed = 100
@export_enum("down", "up", "left", "right") var direction = "down"
var animated_sprite

func _ready():
	add_to_group("hero")
	animated_sprite = $AnimatedSprite2D
	animated_sprite.play("idle_" + direction)

func _input(delta):
	if Input.is_action_pressed("left"):
		direction = "left"
		velocity = Vector2.LEFT * speed
		animated_sprite.play("walk_left")
	elif Input.is_action_pressed("right"):
		direction = "right"
		velocity = Vector2.RIGHT * speed
		animated_sprite.play("walk_right")
	elif Input.is_action_pressed("up"):
		direction = "up"
		velocity = Vector2.UP * speed
		animated_sprite.play("walk_up")
	elif Input.is_action_pressed("down"):
		direction = "down"
		velocity = Vector2.DOWN * speed
		animated_sprite.play("walk_down")
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("idle_" + direction)

func _physics_process(delta):
	move_and_collide(velocity * delta)
