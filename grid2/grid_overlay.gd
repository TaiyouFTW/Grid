## Draws a selected unit's walkable tiles.
class_name UnitOverlay
extends TileMap

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

## Fills the tilemap with the cells, giving a visual representation of the cells a unit can walk.
func draw(cells: Array) -> void:
	for cell in cells:
		set_cell(0, cell, 0, Vector2i(0,0))
