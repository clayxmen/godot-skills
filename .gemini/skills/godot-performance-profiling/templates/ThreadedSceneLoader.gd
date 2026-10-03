# res://src/core/services/scene_loader/threaded_scene_loader.gd
class_name ThreadedSceneLoader
extends Node
## Asynchronous Background Scene Streamer for Godot 4.x

signal progress_updated(progress_ratio: float)
signal load_completed(loaded_scene: PackedScene)
signal load_failed()

var _target_scene_path: String = ""
var _is_loading: bool = false

func start_loading(scene_path: String) -> void:
	_target_scene_path = scene_path
	var err: Error = ResourceLoader.load_threaded_request(scene_path, "", true)
	if err != OK:
		push_error("ThreadedSceneLoader: Failed to request background load for: %s" % scene_path)
		load_failed.emit()
		return
	_is_loading = true

func _process(_delta: float) -> void:
	if not _is_loading:
		return

	var progress_array: Array = []
	var status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(_target_scene_path, progress_array)

	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var progress_val: float = progress_array[0] if not progress_array.is_empty() else 0.0
			progress_updated.emit(progress_val)
		ResourceLoader.THREAD_LOAD_LOADED:
			_is_loading = false
			var scene: PackedScene = ResourceLoader.load_threaded_get(_target_scene_path) as PackedScene
			progress_updated.emit(1.0)
			load_completed.emit(scene)
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			_is_loading = false
			load_failed.emit()
