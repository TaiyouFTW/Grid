extends Node2D

@onready var tile_map = $"../TileMap"
@onready var animated_sprite = $AnimatedSprite2D

var astar_grid: AStarGrid2D
var cell_size: int = 16
var current_id_path: Array[Vector2i]
var current_point_path: PackedVector2Array
var target_position: Vector2
var is_moving: bool
var range: int = 4

func _ready():
	position = position.snapped(Vector2.ZERO * cell_size)
	position += Vector2.ZERO * cell_size/2
	add_to_group("hero")


	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(cell_size, cell_size)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()


	for x in tile_map.get_used_rect().size.x:
		for y in tile_map.get_used_rect().size.y:
			var tile_position = Vector2i(
				x + tile_map.get_used_rect().position.x,
				y + tile_map.get_used_rect().position.y,
			)


			var tile_data: TileData = tile_map.get_cell_tile_data(0, tile_position)
			var tile_data_in_second_layer: TileData = tile_map.get_cell_tile_data(1, tile_position)


			if tile_data == null or tile_data.get_custom_data("walkable") == false or (tile_data_in_second_layer != null and tile_data_in_second_layer.get_custom_data("trees") == true):
				astar_grid.set_point_solid(tile_position)


func _input(event):
	if event.is_action_pressed("move") == false:
		return

	var id_path

	if is_moving:
		id_path = astar_grid.get_id_path(
			tile_map.local_to_map(target_position),
			tile_map.local_to_map(get_global_mouse_position())
		).slice(1)
	else:
		id_path = astar_grid.get_id_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(get_global_mouse_position())
		).slice(1)

	if id_path.is_empty() == false:
		current_id_path = id_path

		current_point_path = astar_grid.get_point_path(
			tile_map.local_to_map(target_position),
			tile_map.local_to_map(get_global_mouse_position())
		)

		for i in current_point_path.size():
			current_point_path[i] = current_point_path[i] + Vector2(cell_size/2, cell_size/2)


func _physics_process(_delta):
	
	if current_id_path.is_empty():
		return


	if is_moving == false:
		target_position = tile_map.map_to_local(current_id_path.front())
		is_moving = true


	var current_position = global_position
	play_animation(global_position, target_position, "walk")
	global_position = global_position.move_toward(target_position, 1)


	if global_position == target_position:
		current_id_path.pop_front()


		if current_id_path.is_empty() == false:
			target_position = tile_map.map_to_local(current_id_path.front())
		else:
			is_moving = false
			play_animation(current_position, target_position, "idle")

func play_animation(current, target, prefix):
	if target.y < current.y:
		animated_sprite.play(prefix + "_up")
	if target.y > current.y:
		animated_sprite.play(prefix + "_down")


	if target.x > current.x:
		animated_sprite.play(prefix + "_right")
	if target.x < current.x:
		animated_sprite.play(prefix + "_left")
