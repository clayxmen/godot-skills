# 🤝 Contributing to Godot Skills Suite

Thank you for your interest in contributing to **`godot-skills`**! This repository is maintained under strict engineering and prompt standards to ensure that AI agents and game developers receive production-grade, warning-free, and high-performance Godot 4.x assets.

---

## 📜 1. Code & Skill Quality Invariants

Every submitted skill or template must adhere to the **Senior Prompt Developer & Godot Engine Architect Standard**:

### ✅ GDScript 2.0 Standards
1. **100% Static Typing**:
   * All variables, function parameters, and return types must be explicitly typed.
   * Untyped `var` or `func do_something():` without `-> void:` is strictly prohibited.
   * Use Typed Arrays (`Array[ItemData]`) and Typed Dictionaries (`Dictionary[StringName, float]`).
2. **Zero Engine Warnings**:
   * Code must compile cleanly without triggering yellow compiler warnings.
   * If a warning is intentional, use `@warning_ignore("warning_name")` with an explanatory comment.
3. **Naming Conventions**:
   * Classes and Custom Types: `PascalCase` (`class_name HealthComponent`)
   * Functions, Variables, and Signals: `snake_case` (`apply_damage()`, `current_health`)
   * Constants and Enums: `UPPER_SNAKE_CASE` (`MAX_CAPACITY`, `enum State { IDLE, RUN }`)
   * StringName identifiers: Prefix with `&` (`&"player"`, `&"enemy"`, `&"Music"`)
4. **Documentation**:
   * Use double-hash docstrings (`##`) on all public signals, exported properties, and methods.

### 🚫 Forbidden Legacy Idioms (Godot 3 Traps)
* ❌ `yield(...)` ➔ ✅ `await ...`
* ❌ `export(int) var x` ➔ ✅ `@export var x: int = 0`
* ❌ `onready var x` ➔ ✅ `@onready var x: Node`
* ❌ `KinematicBody2D/3D` ➔ ✅ `CharacterBody2D/3D`
* ❌ `connect("signal", self, "func")` ➔ ✅ `signal.connect(_on_func)`
* ❌ `emit_signal("signal_name")` ➔ ✅ `signal_name.emit()`
* ❌ `SCREEN_TEXTURE` ➔ ✅ `hint_screen_texture`

---

## 📁 2. Structure of a New Skill

When proposing a new skill, create a dedicated folder inside `skills/`:

```text
skills/
└── godot-[skill-name]/
    ├── SKILL.md                   # Full skill specification & prompt guide
    └── templates/                 # Production-ready, executable .gd / .gdshader / .tscn files
        └── MyTemplate.gd
```

### 📋 `SKILL.md` Template:
```markdown
---
name: godot-[skill-name]
description: |
  [Clear, concise description of what the skill does].
  Use this skill whenever:
    1. [Trigger scenario 1]
    2. [Trigger scenario 2]
  Do NOT use when:
    1. [Anti-trigger scenario 1]
license: MIT
metadata:
  version: v1.0
  engine_target: "Godot 4.3+"
  author: "[Your Name / Handle]"
---

# 🚀 Godot 4 [Skill Name Title]

## 🏗️ 1. Architecture Overview
[Mermaid diagrams and design principles]

## 💎 2. Production Code Implementations
[Fully typed GDScript 2.0 code blocks with comments]

## 🛡️ 3. Anti-Patterns & Best Practices
[Comparison table of wrong vs correct implementations]
```

---

## 🧪 3. Testing Requirements

1. If your skill introduces a new subsystem or component, include a corresponding unit test using the **GUT (Godot Unit Test)** framework in `test/unit/test_[component_name].gd`.
2. Ensure all tests pass headless:
   ```powershell
   pwsh skills/godot-testing-gut-tdd/templates/run_gut_tests.ps1
   ```

---

## 🚀 4. Pull Request (PR) Process

1. Fork the repository and create your branch from `main`:
   ```bash
   git checkout -b feature/godot-new-skill
   ```
2. Commit your changes following Conventional Commits (`feat(skills): add godot-voxel-terrain skill`).
3. Ensure no trailing whitespaces and verify that `README.md` catalog is updated with the new skill.
4. Open a Pull Request with a clear description of the new architecture and usage examples.
