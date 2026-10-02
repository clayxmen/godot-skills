# res://src/ui/debug/performance_monitor_overlay.gd
class_name PerformanceMonitorOverlay
extends CanvasLayer
## Real-Time In-Game FPS, VRAM, and Draw Calls Monitor for Godot 4.x

@onready var label: Label = Label.new()

func _ready() -> void:
	layer = 128
	label.position = Vector2(16, 16)
	label.modulate = Color(0.2, 1.0, 0.4)
	add_child(label)

func _process(_delta: float) -> void:
	var fps: float = Performance.get_monitor(Performance.TIME_FPS)
	var process_time: float = Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
	var physics_time: float = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000.0
	var draw_calls: float = Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
	var video_mem: float = Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) / (1024.0 * 1024.0)

	label.text = "FPS: %d | Frame: %.2f ms | Physics: %.2f ms\nDraw Calls: %d | VRAM: %.1f MB" % [
		int(fps), process_time, physics_time, int(draw_calls), video_mem
	]
