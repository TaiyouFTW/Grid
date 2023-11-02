extends Node2D
@onready var tile_map = $".."

var astar_grid: AStarGrid2D

var cell_size = 16
var grid_size

var tilemap_rect
var tilemap_cell_size
var color = Color.WHITE_SMOKE

func _ready():
	tilemap_rect = tile_map.get_used_rect()
	tilemap_cell_size = Vector2(cell_size, cell_size)
	set_process(true)

func _process(delta):
	queue_redraw()

func _draw():
	for x in tile_map.get_used_rect().size.x:
		for y in tile_map.get_used_rect().size.y:
			var tile_position = Vector2i(
				x + tile_map.get_used_rect().position.x,
				y + tile_map.get_used_rect().position.y,
			)
			var square_position = Vector2(tile_position.x * cell_size, tile_position.y * cell_size)
			draw_line(square_position, square_position + Vector2(cell_size, 0), color)
			draw_line(square_position + Vector2(cell_size, 0), square_position + Vector2(cell_size, cell_size), color)
			draw_line(square_position + Vector2(cell_size, cell_size), square_position + Vector2(0, cell_size), color)
			draw_line(square_position + Vector2(0, cell_size), square_position, color)
