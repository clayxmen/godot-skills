# res://src/core/services/pcg/cellular_automata_cave_generator.gd
class_name CellularAutomataCaveGenerator
extends RefCounted
## Cellular Automata 4-5 Rule Organic Cave Generator for Godot 4.x

static func generate_caves(width: int, height: int, fill_ratio: float = 0.45, iterations: int = 5) -> Array[Array]:
	var map: Array[Array] = []
	map.resize(height)

	# 1. Random noise seed
	for y in range(height):
		var row: Array[int] = []
		row.resize(width)
		for x in range(width):
			if x == 0 or x == width - 1 or y == 0 or y == height - 1:
				row[x] = 1
			else:
				row[x] = 1 if randf() < fill_ratio else 0
		map[y] = row

	# 2. Simulation smoothing
	for step in range(iterations):
		var next_map: Array[Array] = []
		next_map.resize(height)
		for y in range(height):
			var new_row: Array[int] = []
			new_row.resize(width)
			for x in range(width):
				if x == 0 or x == width - 1 or y == 0 or y == height - 1:
					new_row[x] = 1
				else:
					var neighbor_walls: int = _count_wall_neighbors(map, x, y, width, height)
					new_row[x] = 1 if neighbor_walls > 4 else 0
			next_map[y] = new_row
		map = next_map

	return map

static func _count_wall_neighbors(map: Array[Array], x: int, y: int, width: int, height: int) -> int:
	var count: int = 0
	for ny in range(y - 1, y + 2):
		for nx in range(x - 1, x + 2):
			if nx == x and ny == y:
				continue
			if nx < 0 or nx >= width or ny < 0 or ny >= height or map[ny][nx] == 1:
				count += 1
	return count
