# res://src/ui/widgets/neobrutalism_button.gd
class_name NeobrutalismButton
extends Button
## Tactile Physics-Feel Animated Button Widget for Godot 4.x

@export var hover_scale: Vector2 = Vector2(1.04, 1.04)
@export var click_offset: Vector2 = Vector2(2.0, 2.0)
@export var animation_duration: float = 0.08

var _current_tween: Tween

func _ready() -> void:
	pivot_offset = size * 0.5
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

func _on_mouse_entered() -> void:
	_animate_scale(hover_scale)

func _on_mouse_exited() -> void:
	_animate_scale(Vector2.ONE)

func _on_focus_entered() -> void:
	_animate_scale(hover_scale)

func _on_focus_exited() -> void:
	_animate_scale(Vector2.ONE)

func _on_button_down() -> void:
	position += click_offset
	if Events and Events.has_signal("sfx_playback_requested"):
		Events.sfx_playback_requested.emit(&"ui_click", Vector3.ZERO, 0.05)

func _on_button_up() -> void:
	position -= click_offset

func _animate_scale(target_scale: Vector2) -> void:
	if _current_tween and _current_tween.is_valid():
		_current_tween.kill()
	_current_tween = create_tween()
	_current_tween.tween_property(self, "scale", target_scale, animation_duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
