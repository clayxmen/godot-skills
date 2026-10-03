# res://src/core/services/pcg/noise_terrain_generator.gd
class_name NoiseTerrainGenerator
extends Node
## FastNoiseLite Multi-Octave Heightmap & Biome Generator for Godot 4.3+

enum BiomeType { DEEP_WATER, SHALLOW_WATER, SAND, GRASS, FOREST, ROCK, SNOW }

@export var noise_seed: int = 1337
@export var frequency: float = 0.02
@export var octaves: int = 4

var _noise: FastNoiseLite = FastNoiseLite.new()

func _ready() -> void:
	_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	_noise.seed = noise_seed
	_noise.frequency = frequency
	_noise.fractal_octaves = octaves

## Returns the biome classification for a world grid coordinate.
func get_biome_at(x: int, y: int) -> BiomeType:
	var elevation: float = (_noise.get_noise_2d(float(x), float(y)) + 1.0) * 0.5 # 0.0 to 1.0

	if elevation < 0.25:
		return BiomeType.DEEP_WATER
	elif elevation < 0.35:
		return BiomeType.SHALLOW_WATER
	elif elevation < 0.42:
		return BiomeType.SAND
	elif elevation < 0.65:
		return BiomeType.GRASS
	elif elevation < 0.80:
		return BiomeType.FOREST
	elif elevation < 0.90:
		return BiomeType.ROCK
	else:
		return BiomeType.SNOW
