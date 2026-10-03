---
name: godot-typed-gdscript-mastery
description: |
  Authoritative guide and standards for writing 100% static-typed, warning-free GDScript 2.0
  in Godot 4.x (Godot 4.3+). Covers strict type annotations, Custom Resources (.tres),
  crash-proof @tool script architecture, memory safety (RefCounted vs Node), and Godot 3 vs 4 guardrails.

  Use this skill whenever:
    1. Writing, reviewing, or refactoring GDScript files in Godot 4.x.
    2. Implementing data-driven architectures with Custom Resources (`extends Resource`).
    3. Building in-editor tooling, visual gizmos, or level design helpers using `@tool`.
    4. Eliminating engine warnings, compiler errors, and dynamic typing performance penalties.
    5. Ensuring memory safety, proper garbage collection, and leak-free node lifecycles.

  Do NOT use when:
    1. Writing low-level C++ GDExtensions or C# code.
    2. Writing pure GLSL / Godot Shader code.
license: MIT
metadata:
  version: v1.0
  engine_target: "Godot 4.3+"
  author: "Senior Godot AI Architect & Prompt Engineer"
---

# ⚡ GDScript 2.0 Mastery & Static Typing Standards

This skill establishes the engineering standards for writing **100% statically typed, warning-free, and high-performance GDScript 2.0** in Godot 4.x.

---

## 🎯 1. Strict Typing Invariants

Every line of GDScript must have explicit type contracts. Never allow untyped `var` or unannotated function returns.

### 🚫 Unacceptable Dynamic Typing vs ✅ Production Static Typing

```gdscript
# ❌ UNACCEPTABLE (Dynamic typing, runtime crash prone, slow)
var speed = 300
var player
var inventory = []

func attack(target, damage):
	target.take_damage(damage)
	return true
```

```gdscript
# ✅ PRODUCTION GRADE (100% Statically Typed, JIT optimized, zero warnings)
var speed: float = 300.0
var player: CharacterBody2D = null
var inventory: Array[ItemData] = []
var loot_weights: Dictionary[StringName, float] = {}

func attack(target: HitboxComponent, damage: float) -> bool:
	if not is_instance_valid(target):
		return false
	target.receive_damage(damage)
	return true
```

---

## 💎 2. Custom Resource Data-Driven Architecture

In Godot 4, **Custom Resources** (`extends Resource`) replace bloated JSON parsing with binary-efficient, inspector-friendly, hot-reloadable data objects.

### 💎 Production Custom Resource: ItemData.gd
```gdscript
# res://src/core/types/item_data.gd
class_name ItemData
extends Resource

enum ItemRarity { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }
enum ItemCategory { CONSUMABLE, WEAPON, ARMOR, MATERIAL }

@export_group("Identity")
@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var icon: Texture2D

@export_group("Classification")
@export var category: ItemCategory = ItemCategory.CONSUMABLE
@export var rarity: ItemRarity = ItemRarity.COMMON
@export_range(1, 999, 1) var max_stack_size: int = 99

@export_group("Economy & Stats")
@export_range(0, 1000000, 1) var gold_value: int = 10
@export var stat_modifiers: Dictionary[StringName, float] = {}

## Returns a formatted BBCode colored title based on rarity.
func get_formatted_title() -> String:
	var color_hex: String = "#ffffff"
	match rarity:
		ItemRarity.COMMON: color_hex = "#b0b0b0"
		ItemRarity.UNCOMMON: color_hex = "#20df40"
		ItemRarity.RARE: color_hex = "#0088ff"
		ItemRarity.EPIC: color_hex = "#9d00ff"
		ItemRarity.LEGENDARY: color_hex = "#ffaa00"
	return "[color=%s]%s[/color]" % [color_hex, display_name]
```

---

## 🛠️ 3. Safe `@tool` Script Development (Zero-Crash Protocol)

When creating in-editor `@tool` scripts, always guard engine-critical code to prevent editor freezes and null reference crashes.

### 🛡️ The 4 Laws of `@tool` Scripts:
1. **Always Check `Engine.is_editor_hint()`**:
   Separate editor visual updates from gameplay physics or logic.
2. **Setter Invariants**:
   When an `@export` property setter triggers a redraw, check if the node is in the tree before calling node-dependent functions.
3. **Notify Changes**:
   Use `notify_property_list_changed()` and `queue_redraw()` to update inspector and 2D/3D viewport seamlessly.
4. **Clean Exit**:
   Always disconnect dynamic signals and remove generated children in `_exit_tree()`.

### 💎 Production `@tool` Node: CustomGridGizmo.gd
```gdscript
# res://src/tools/custom_grid_gizmo.gd
@tool
class_name CustomGridGizmo
extends Node2D

@export_group("Grid Properties")
@export var cell_size: Vector2 = Vector2(32, 32):
	set(value):
		cell_size = value.clamp(Vector2(4, 4), Vector2(512, 512))
		if is_inside_tree():
			queue_redraw()

@export var grid_dimensions: Vector2i = Vector2i(10, 10):
	set(value):
		grid_dimensions = value.clamp(Vector2i(1, 1), Vector2i(100, 100))
		if is_inside_tree():
			queue_redraw()

@export var line_color: Color = Color(0.2, 0.8, 1.0, 0.4):
	set(value):
		line_color = value
		if is_inside_tree():
			queue_redraw()

func _draw() -> void:
	if not Engine.is_editor_hint():
		return # Do not render editor debug grid in production build

	# Draw horizontal lines
	for y: int in range(grid_dimensions.y + 1):
		var start: Vector2 = Vector2(0, y * cell_size.y)
		var end: Vector2 = Vector2(grid_dimensions.x * cell_size.x, y * cell_size.y)
		draw_line(start, end, line_color, 1.0)

	# Draw vertical lines
	for x: int in range(grid_dimensions.x + 1):
		var start: Vector2 = Vector2(x * cell_size.x, 0)
		var end: Vector2 = Vector2(x * cell_size.x, grid_dimensions.y * cell_size.y)
		draw_line(start, end, line_color, 1.0)
```

---

## 🧠 4. Memory Safety: `RefCounted` vs `Node` / `Object`

| Base Class | Lifecycle / Memory Model | Correct Destruction Method | Example Use Case |
| :--- | :--- | :--- | :--- |
| **`RefCounted`** | Automatic (Freed when reference count hits 0) | Set variable to `null` | Custom Resources, DTOs, Math/Path Calculators |
| **`Node`** | Manual (Managed by Scene Tree) | `node.queue_free()` | Entities, UI Controls, Cameras, Spatial Objects |
| **`Object`** | Manual (Raw C++ Pointer) | `obj.free()` (Dangerous!) | Low-level Server wrappers (Prefer RefCounted) |

> [!WARNING]
> **Dangling Reference Trap**: Never hold raw `Node` references across scene unloads without using `weakref()` or checking `is_instance_valid(node)`.

---

## 🚫 5. Godot 3 vs Godot 4 Syntax Migration Guardrails

Ensure code NEVER incorporates outdated Godot 3 idioms:

| Feature | ❌ Godot 3 (Legacy/Forbidden) | ✅ Godot 4.x (Standard) |
| :--- | :--- | :--- |
| **Async Waiting** | `yield(get_tree().create_timer(1.0), "timeout")` | `await get_tree().create_timer(1.0).timeout` |
| **Exporting** | `export(int) var count = 0` | `@export var count: int = 0` |
| **Signal Connection**| `connect("body_entered", self, "_on_body_entered")`| `body_entered.connect(_on_body_entered)` |
| **Signal Emission** | `emit_signal("player_died", score)` | `player_died.emit(score)` |
| **Physics 2D/3D** | `KinematicBody2D` / `KinematicBody` | `CharacterBody2D` / `CharacterBody3D` |
| **Super Call** | `._ready()` | `super._ready()` or `super()` |
| **Unique Names** | `get_node("Path/To/Node")` | `%MyUniqueNode` |
