extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var cell_size: int = 16

func _ready():
#	animated_sprite_2d.play("pulse")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	var mouse_position = (get_global_mouse_position() / cell_size).floor() * cell_size
	var snapped_position = mouse_position.snapped(Vector2(cell_size, cell_size))
	var offset = Vector2(cell_size/2, cell_size/2)

	position = snapped_position + offset
