# res://src/core/services/audio/audio_director.gd
extends Node
## Global Dynamic Audio Director & BGM Crossfader for Godot 4.x
## Register as an AutoLoad named 'AudioDirector'.

@export var music_bus_name: StringName = &"Music"
@export var sfx_bus_name: StringName = &"SFX"
@export var default_fade_duration: float = 1.2

var _player_a: AudioStreamPlayer
var _player_b: AudioStreamPlayer
var _active_player: AudioStreamPlayer = null
var _current_tween: Tween = null

func _ready() -> void:
	_player_a = AudioStreamPlayer.new()
	_player_a.bus = music_bus_name
	add_child(_player_a)

	_player_b = AudioStreamPlayer.new()
	_player_b.bus = music_bus_name
	add_child(_player_b)

	_active_player = _player_a

func play_bgm(stream: AudioStream, fade_duration: float = -1.0) -> void:
	if stream == null:
		return

	if _active_player.playing and _active_player.stream == stream:
		return

	var duration: float = default_fade_duration if fade_duration <= 0.0 else fade_duration
	var outgoing_player: AudioStreamPlayer = _active_player
	var incoming_player: AudioStreamPlayer = _player_b if _active_player == _player_a else _player_a

	if _current_tween and _current_tween.is_valid():
		_current_tween.kill()

	incoming_player.stream = stream
	incoming_player.volume_db = -80.0
	incoming_player.play()

	_current_tween = create_tween().set_parallel(true)
	_current_tween.tween_property(incoming_player, "volume_db", 0.0, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	if outgoing_player.playing:
		_current_tween.tween_property(outgoing_player, "volume_db", -80.0, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		_current_tween.chain().tween_callback(outgoing_player.stop)

	_active_player = incoming_player

func stop_bgm(fade_duration: float = 1.0) -> void:
	if not _active_player.playing:
		return

	if _current_tween and _current_tween.is_valid():
		_current_tween.kill()

	_current_tween = create_tween()
	_current_tween.tween_property(_active_player, "volume_db", -80.0, fade_duration)
	_current_tween.tween_callback(_active_player.stop)

func duck_music(duck_db: float = -12.0, duration: float = 0.3) -> void:
	if _active_player.playing:
		var tw: Tween = create_tween()
		tw.tween_property(_active_player, "volume_db", duck_db, duration)

func unduck_music(duration: float = 0.5) -> void:
	if _active_player.playing:
		var tw: Tween = create_tween()
		tw.tween_property(_active_player, "volume_db", 0.0, duration)
