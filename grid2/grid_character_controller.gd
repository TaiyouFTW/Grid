extends Node2D
@onready var camera_2d = $Swordsman/Camera2D

const ray_length = 1000

#func _physics_process(delta):
#	if Input.is_action_pressed("move"):
#		var space_state = get_world_2d().direct_space_state
#		var query = PhysicsRayQueryParameters2D.create(global_position, get_global_mouse_position())
#		var result = space_state.intersect_ray(query)
#		print(result)
