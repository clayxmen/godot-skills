# GitHub Copilot Instructions for Godot 4.x

- **Engine Target**: Godot 4.3+ with GDScript 2.0.
- **Strict Typing**: Always write 100% statically typed GDScript code.
- **Component Pattern**: Use Composition over Inheritance (attach Component nodes).
- **Signal Safety**: Use `signal_name.connect(_on_handler)` and typed signals.
- **Forbidden Legacy**: Never generate Godot 3 syntax (`yield`, `export var`, `KinematicBody`).
