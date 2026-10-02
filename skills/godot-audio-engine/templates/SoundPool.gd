# res://src/core/services/audio/sound_pool.gd
class_name SoundPool
extends Node
## Dynamic Sound Pool Manager with Pitch Randomization for Godot 4.x

@export var sfx_bus: StringName = &"SFX"
@export var pool_size: int = 12

var _players: Array[AudioStreamPlayer] = []
var _next_index: int = 0

func _ready() -> void:
	for i in range(pool_size):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.bus = sfx_bus
		add_child(player)
		_players.append(player)

func play_sound(stream: AudioStream, pitch_variance: float = 0.1, volume_db: float = 0.0) -> void:
	if stream == null or _players.is_empty():
		return

	var player: AudioStreamPlayer = _players[_next_index]
	_next_index = (_next_index + 1) % pool_size

	player.stream = stream
	player.volume_db = volume_db
	if pitch_variance > 0.0:
		player.pitch_scale = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
	else:
		player.pitch_scale = 1.0

	player.play()
