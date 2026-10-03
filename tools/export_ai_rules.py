#!/usr/bin/env python3
"""
Universal Multi-Agent AI Rule Exporter for Godot Skills.
Exports 25+ Godot skills into native configurations for:
- Antigravity (.gemini/skills/)
- Cursor IDE (.cursor/rules/)
- Claude Code (CLAUDE.md)
- GitHub Copilot (.github/copilot-instructions.md)

Zero external dependencies (pure Python 3 standard library).
"""

import os
import sys
import re
import shutil
import argparse
from pathlib import Path

# Ensure UTF-8 stdout on Windows
if sys.platform == "win32":
    try:
        sys.stdout.reconfigure(encoding="utf-8")
        sys.stderr.reconfigure(encoding="utf-8")
    except Exception:
        pass


def parse_frontmatter(content: str) -> tuple[dict, str]:
    """Parses YAML-style frontmatter from a markdown file without external dependencies."""
    metadata = {}
    body = content

    if content.startswith("---"):
        parts = content.split("---", 2)
        if len(parts) >= 3:
            raw_frontmatter = parts[1].strip()
            body = parts[2].strip()

            for line in raw_frontmatter.splitlines():
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                if ":" in line:
                    key, val = line.split(":", 1)
                    key = key.strip()
                    val = val.strip().strip('"').strip("'")
                    metadata[key] = val

    return metadata, body


def get_all_skills(skills_dir: Path) -> list[dict]:
    """Discovers and parses all SKILL.md files in the skills directory."""
    skills = []
    if not skills_dir.exists():
        print(f"[!] Skills directory not found: {skills_dir}")
        return skills

    for skill_folder in sorted(skills_dir.iterdir()):
        if not skill_folder.is_dir():
            continue

        skill_md = skill_folder / "SKILL.md"
        if not skill_md.exists():
            continue

        content = skill_md.read_text(encoding="utf-8")
        metadata, body = parse_frontmatter(content)
        name = metadata.get("name", skill_folder.name)
        description = metadata.get("description", f"Expert guide for {name}")

        skills.append({
            "name": name,
            "folder": skill_folder,
            "skill_md": skill_md,
            "metadata": metadata,
            "description": description,
            "content": content,
            "body": body
        })

    return skills


def export_gemini_skills(target_project: Path, skills: list[dict]) -> int:
    """Exports native Antigravity/Gemini agent skills to .gemini/skills/."""
    gemini_skills_dir = target_project / ".gemini" / "skills"
    gemini_skills_dir.mkdir(parents=True, exist_ok=True)

    count = 0
    for skill in skills:
        dest_folder = gemini_skills_dir / skill["folder"].name
        if dest_folder.exists():
            shutil.rmtree(dest_folder)
        shutil.copytree(skill["folder"], dest_folder)
        count += 1

    print(f"  [+] [Antigravity] Exported {count} skills to: {gemini_skills_dir}")
    return count


def export_cursor_rules(target_project: Path, skills: list[dict]) -> int:
    """Exports Cursor IDE rules to .cursor/rules/godot-<skill>.mdc."""
    cursor_rules_dir = target_project / ".cursor" / "rules"
    cursor_rules_dir.mkdir(parents=True, exist_ok=True)

    count = 0
    for skill in skills:
        rule_file = cursor_rules_dir / f"{skill['name']}.mdc"
        
        cursor_content = (
            "---\n"
            f"description: \"{skill['description'].splitlines()[0] if skill['description'] else skill['name']}\"\n"
            "globs: \"*.gd, *.tscn, *.tres, *.gdshader, project.godot\"\n"
            "alwaysApply: false\n"
            "---\n\n"
            f"{skill['body']}\n"
        )
        rule_file.write_text(cursor_content, encoding="utf-8")
        count += 1

    master_rule = cursor_rules_dir / "godot_architecture_master.mdc"
    master_content = (
        "---\n"
        "description: \"Godot 4.3+ Architecture, Static Typing Standards, and Component Rules\"\n"
        "globs: \"*.gd, *.tscn, *.tres, *.gdshader, project.godot\"\n"
        "alwaysApply: true\n"
        "---\n\n"
        "# Godot 4.x Master Architecture & Strict GDScript Rules\n\n"
        "1. **100% Static Typing**: All variables, params, and returns MUST be explicitly typed (e.g. `var x: float = 0.0`, `func f() -> void:`).\n"
        "2. **Zero Godot 3 Legacy**: Never use `yield`, `export var`, `KinematicBody`, `connect(\"str\"...)`, `SCREEN_TEXTURE`.\n"
        "3. **Composition over Inheritance**: Use Component nodes (`HealthComponent`, `HitboxComponent`) over deep inheritance.\n"
        "4. **Decoupled Event Bus**: Communicate across scenes using typed signals via `Events` AutoLoad.\n"
    )
    master_rule.write_text(master_content, encoding="utf-8")
    count += 1

    print(f"  [+] [Cursor IDE] Exported {count} rules to: {cursor_rules_dir}")
    return count


def export_claude_instructions(target_project: Path, skills: list[dict]) -> Path:
    """Exports Claude Code instruction file CLAUDE.md."""
    claude_file = target_project / "CLAUDE.md"

    skills_index = "\n".join([f"- **`{s['name']}`**: {s['description'].splitlines()[0] if s['description'] else ''}" for s in skills])

    content = f"""# Godot 4.x Development Guide (CLAUDE.md)

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

{skills_index}
"""
    claude_file.write_text(content, encoding="utf-8")
    print(f"  [+] [Claude Code] Generated: {claude_file}")
    return claude_file


def export_copilot_instructions(target_project: Path, skills: list[dict]) -> Path:
    """Exports GitHub Copilot instruction file .github/copilot-instructions.md."""
    copilot_dir = target_project / ".github"
    copilot_dir.mkdir(parents=True, exist_ok=True)
    copilot_file = copilot_dir / "copilot-instructions.md"

    content = """# GitHub Copilot Instructions for Godot 4.x

- **Engine Target**: Godot 4.3+ with GDScript 2.0.
- **Strict Typing**: Always write 100% statically typed GDScript code.
- **Component Pattern**: Use Composition over Inheritance (attach Component nodes).
- **Signal Safety**: Use `signal_name.connect(_on_handler)` and typed signals.
- **Forbidden Legacy**: Never generate Godot 3 syntax (`yield`, `export var`, `KinematicBody`).
"""
    copilot_file.write_text(content, encoding="utf-8")
    print(f"  [+] [GitHub Copilot] Generated: {copilot_file}")
    return copilot_file


def main():
    parser = argparse.ArgumentParser(description="Export Godot Skills to multi-agent AI configurations.")
    parser.add_argument("--source", type=str, default="skills", help="Path to skills source directory")
    parser.add_argument("--target", type=str, default=".", help="Path to target Godot project directory")
    parser.add_argument("--all", action="store_true", help="Export to all AI assistant formats (default)")
    parser.add_argument("--gemini", action="store_true", help="Export Antigravity (.gemini/skills/)")
    parser.add_argument("--cursor", action="store_true", help="Export Cursor (.cursor/rules/)")
    parser.add_argument("--claude", action="store_true", help="Export Claude Code (CLAUDE.md)")
    parser.add_argument("--copilot", action="store_true", help="Export GitHub Copilot (.github/)")

    args = parser.parse_args()

    source_path = Path(args.source).resolve()
    target_path = Path(args.target).resolve()

    if not source_path.exists():
        script_dir = Path(__file__).parent.parent / "skills"
        if script_dir.exists():
            source_path = script_dir

    print(f"\n[Godot Skills Exporter] Packaging from: {source_path}")
    print(f"Target Project: {target_path}\n")

    skills = get_all_skills(source_path)
    if not skills:
        print("[!] No skills found to export. Aborting.")
        sys.exit(1)

    print(f"Loaded {len(skills)} skills. Exporting AI context configs...")

    export_all = args.all or not (args.gemini or args.cursor or args.claude or args.copilot)

    if export_all or args.gemini:
        export_gemini_skills(target_path, skills)
    if export_all or args.cursor:
        export_cursor_rules(target_path, skills)
    if export_all or args.claude:
        export_claude_instructions(target_path, skills)
    if export_all or args.copilot:
        export_copilot_instructions(target_path, skills)

    print("\nAll AI Agent rules successfully exported! The project is now 100% AI-Ready.\n")


if __name__ == "__main__":
    main()
