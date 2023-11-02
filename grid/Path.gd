extends Node2D
@onready var player = $"../Swordsman"

func _process(delta):
	show()
	queue_redraw()

func _draw():
	if player.current_point_path.is_empty():
		return

	draw_polyline(player.current_point_path, Color.RED)
	if player.position == player.current_point_path[player.current_point_path.size() - 1]:
		hide()
