# Godot 4.x Development Guide (CLAUDE.md)

> This project follows **Senior Godot Engine Architect & Clean Architecture** standards for **Godot 4.3+**.

---

## Core Engineering Standards

1. **Strict GDScript 2.0 Static Typing**:
   - Always type all variables, function arguments, and return types explicitly (`func take_damage(amount: float) -> void:`).
   - Use typed arrays (`Array[ItemData]`) and typed dictionaries (`Dictionary[StringName, float]`).
   - Zero compilation warnings allowed.

2. **No Godot 3 Legacy Idioms**:
   - `await` instead of `yield`
   - `@export var x: int = 0` instead of `export(int) var x`
   - `@onready var n: Node` instead of `onready var n`
   - `CharacterBody2D/3D` instead of `KinematicBody2D/3D`
   - `signal.connect(_func)` instead of `connect("signal", self, "func")`
   - `signal.emit()` instead of `emit_signal("signal")`

3. **Component-Based Architecture**:
   - Favor atomic `Node` components (`HealthComponent`, `HitboxComponent`, `InventoryComponent`) over deep inheritance trees.
   - Downward method calls, upward typed signals.

---

## Testing & Execution

- **Run Unit Tests (GUT)**:
  `godot --headless -s addons/gut/gut_cmdln.gd -gdir=res://test/unit -gexit`
- **Export Release Build**:
  `godot --headless --export-release "Windows Desktop" build/windows/game.exe`

---

## 25 Available Skill Modules in this Project:

- **`godot-ai-behavior-trees`**: |
- **`godot-architecture-foundation`**: |
- **`godot-audio-engine`**: |
- **`godot-character-controllers`**: |
- **`godot-ci-cd-export-automation`**: |
- **`godot-combat-hitbox-hurtbox`**: |
- **`godot-dialogue-quest-engine`**: |
- **`godot-event-bus-signals`**: |
- **`godot-hud-minimap-camera`**: |
- **`godot-input-gamepad-remapping`**: |
- **`godot-inventory-item-system`**: |
- **`godot-multiplayer-high-level`**: |
- **`godot-navigation-server`**: |
- **`godot-performance-profiling`**: |
- **`godot-procedural-generation`**: |
- **`godot-resource-data-tables`**: |
- **`godot-save-persistence-security`**: |
- **`godot-shader-development`**: |
- **`godot-sqlite-local-db`**: |
- **`godot-state-machine-hsm`**: |
- **`godot-testing-gut-tdd`**: |
- **`godot-typed-gdscript-mastery`**: |
- **`godot-ui-ux-design-system`**: |
- **`godot-utility-ai-goap`**: |
- **`godot-vfx-particles`**: |
