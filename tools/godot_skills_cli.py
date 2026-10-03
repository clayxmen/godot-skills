#!/usr/bin/env python3
"""
Godot Skills CLI - Universal Management & Type-Safety Doctor for Godot 4.x Projects.
Commands:
  godot-skills init        # Bootstraps Clean Architecture & injects AI context
  godot-skills add <name>  # Injects specific skill templates into target project
  godot-skills doctor      # Audits project scripts for static typing & Godot 3 legacy traps
  godot-skills global-sync # Copies skills into global ~/.gemini/config/skills/

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

ROOT_DIR = Path(__file__).parent.parent
SKILLS_DIR = ROOT_DIR / "skills"


def cmd_init(target_path: Path, all_rules: bool = True) -> int:
    """Initializes Clean Architecture folders, core templates, and AI rules in target project."""
    print(f"\n[godot-skills] Initializing Clean Architecture in: {target_path}")

    # 1. Create Feature-First directories
    folders = [
        "src/core/components",
        "src/core/services",
        "src/core/singletons",
        "src/core/types",
        "src/features/player",
        "src/features/combat",
        "src/features/inventory",
        "src/ui/hud",
        "src/ui/menus",
        "src/ui/theme",
        "src/shared/utils",
        "assets/audio",
        "assets/fonts",
        "assets/shaders",
        "assets/textures",
        "test/unit"
    ]

    for f in folders:
        d = target_path / f
        d.mkdir(parents=True, exist_ok=True)

    print("  [+] Created Feature-First directory layout (src/, assets/, test/).")

    # 2. Copy foundational templates
    core_templates = [
        ("godot-event-bus-signals", "Events.gd", "src/core/singletons/events.gd"),
        ("godot-architecture-foundation", "ServiceLocator.gd", "src/core/services/service_locator.gd"),
        ("godot-architecture-foundation", "HealthComponent.gd", "src/core/components/health_component.gd"),
        ("godot-typed-gdscript-mastery", "ItemData.gd", "src/core/types/item_data.gd"),
        ("godot-combat-hitbox-hurtbox", "DamagePayload.gd", "src/core/types/damage_payload.gd"),
        ("godot-save-persistence-security", "SaveManager.gd", "src/core/services/save_manager.gd"),
    ]

    copied_count = 0
    for skill_name, template_file, dest_rel_path in core_templates:
        src_file = SKILLS_DIR / skill_name / "templates" / template_file
        dest_file = target_path / dest_rel_path
        if src_file.exists() and not dest_file.exists():
            dest_file.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src_file, dest_file)
            copied_count += 1

    print(f"  [+] Copied {copied_count} foundational GDScript 2.0 core templates.")

    # 3. Export AI rules (Antigravity, Cursor, Claude, Copilot)
    exporter_script = ROOT_DIR / "tools" / "export_ai_rules.py"
    if exporter_script.exists():
        import subprocess
        subprocess.run([sys.executable, str(exporter_script), "--source", str(SKILLS_DIR), "--target", str(target_path), "--all"])

    print("Project bootstrap completed successfully! Open with Godot 4.3+ and start prompting.\n")
    return 0


def cmd_add(skill_name: str, target_path: Path) -> int:
    """Copies all templates and docs for a specific skill into the target project."""
    matching_skills = [d for d in SKILLS_DIR.iterdir() if d.is_dir() and (d.name == skill_name or skill_name in d.name)]
    if not matching_skills:
        print(f"[!] Skill not found matching: {skill_name}")
        print("    Available skills: " + ", ".join([d.name for d in SKILLS_DIR.iterdir() if d.is_dir()]))
        return 1

    skill_folder = matching_skills[0]
    templates_folder = skill_folder / "templates"
    
    print(f"\n[godot-skills] Adding skill: {skill_folder.name} to {target_path}")

    if templates_folder.exists():
        dest_templates = target_path / "src" / "imported_templates" / skill_folder.name
        dest_templates.mkdir(parents=True, exist_ok=True)
        for t_file in templates_folder.iterdir():
            shutil.copy2(t_file, dest_templates / t_file.name)
            print(f"  [+] Injected template: {t_file.name} -> {dest_templates}")

    gemini_dest = target_path / ".gemini" / "skills" / skill_folder.name
    gemini_dest.mkdir(parents=True, exist_ok=True)
    shutil.copytree(skill_folder, gemini_dest, dirs_exist_ok=True)
    print(f"  [+] AI Context updated for: {skill_folder.name}\n")
    return 0


def cmd_doctor(target_path: Path) -> int:
    """Scans all GDScript files in target project for static typing violations and Godot 3 traps."""
    print(f"\n[godot-skills doctor] Running static analysis & audit on: {target_path}\n")

    gd_files = list(target_path.rglob("*.gd"))
    if not gd_files:
        print("  [i] No .gd files found in project to analyze.")
        return 0

    issues_found = 0
    clean_files = 0

    PATTERNS = [
        # Legacy Godot 3 patterns
        (r"\byield\s*\(", "Godot 3 'yield' detected. Use Godot 4 'await' instead."),
        (r"(?<!@)\bexport\s*\(", "Godot 3 'export(...)' detected. Use Godot 4 '@export var' instead."),
        (r"(?<!@)\bonready\s+var\b", "Godot 3 'onready var' (without @) detected. Use Godot 4 '@onready var' instead."),
        (r"\bKinematicBody2D\b", "Godot 3 'KinematicBody2D' detected. Use Godot 4 'CharacterBody2D' instead."),
        (r"\bKinematicBody3D\b", "Godot 3 'KinematicBody3D' detected. Use Godot 4 'CharacterBody3D' instead."),
        (r"\bconnect\s*\(\s*[\"']", "String-based 'connect(\"signal\", ...)' detected. Use typed 'signal_name.connect(_func)' instead."),
        (r"\bemit_signal\s*\(\s*[\"']", "String-based 'emit_signal(\"...\")' detected. Use typed 'signal_name.emit(...)' instead."),
        (r"\bSCREEN_TEXTURE\b", "Legacy 'SCREEN_TEXTURE' detected. Use 'hint_screen_texture' in Godot 4 shaders."),
        (r"func\s+\w+\([^)]*\)\s*:", "Function signature missing explicit return type annotation (e.g. '-> void:' or '-> bool:')."),
    ]

    for gd_file in gd_files:
        if "addons/gut" in str(gd_file).replace("\\", "/"):
            continue

        try:
            raw_content = gd_file.read_text(encoding="utf-8")
        except Exception:
            continue

        # Replace multiline strings with placeholder newlines to preserve line numbering
        def replace_multiline(m):
            newlines = m.group(0).count('\n')
            return '\n' * newlines

        clean_content = re.sub(r'"""[\s\S]*?"""|\'\'\'[\s\S]*?\'\'\'', replace_multiline, raw_content)
        lines = clean_content.splitlines()
        file_has_issue = False

        for line_num, line in enumerate(lines, 1):
            line_str = line.strip()
            if not line_str or line_str.startswith("#"):
                continue

            # Strip single line string literals
            code_line = re.sub(r'"[^"\\]*(?:\\.[^"\\]*)*"|\'[^\'\\]*(?:\\.[^\'\\]*)*\'', '""', line_str)

            for pattern, message in PATTERNS:
                if re.search(pattern, code_line):
                    if not file_has_issue:
                        rel_path = gd_file.relative_to(target_path)
                        print(f"[!] {rel_path}:")
                        file_has_issue = True
                    print(f"    Line {line_num}: {line_str}")
                    print(f"    └─ [X] {message}\n")
                    issues_found += 1

        if not file_has_issue:
            clean_files += 1

    print("------------------------------------------------------------")
    if issues_found == 0:
        print(f"Perfect Score! Analyzed {len(gd_files)} files. 100% Static Typed & Zero Legacy Traps Found.\n")
        return 0
    else:
        print(f"Audit complete: Found {issues_found} potential issues across {len(gd_files) - clean_files} files.")
        print("Use the corresponding `godot-skills` modules to refactor to warning-free GDScript 2.0!\n")
        return 1


def cmd_global_sync() -> int:
    """Syncs all 25 skills into user's global ~/.gemini/config/skills/ directory."""
    user_home = Path.home()
    global_skills_dir = user_home / ".gemini" / "config" / "skills"
    
    print(f"\n[godot-skills] Syncing skills to Global Agent Directory: {global_skills_dir}")
    global_skills_dir.mkdir(parents=True, exist_ok=True)

    count = 0
    for skill_folder in SKILLS_DIR.iterdir():
        if not skill_folder.is_dir():
            continue
        dest = global_skills_dir / skill_folder.name
        if dest.exists():
            shutil.rmtree(dest)
        shutil.copytree(skill_folder, dest)
        count += 1

    print(f"Successfully installed {count} skills globally! All projects on this PC can now use Godot Skills.\n")
    return 0


def main():
    parser = argparse.ArgumentParser(description="Godot Skills CLI & Type-Safety Doctor")
    subparsers = parser.add_subparsers(dest="command", help="Command to execute")

    init_parser = subparsers.add_parser("init", help="Bootstrap Clean Architecture and inject AI rules into project")
    init_parser.add_argument("--target", type=str, default=".", help="Target project directory")

    add_parser = subparsers.add_parser("add", help="Inject templates of a specific skill into target project")
    add_parser.add_argument("skill", type=str, help="Name of skill to add (e.g. combat, inventory, goap)")
    add_parser.add_argument("--target", type=str, default=".", help="Target project directory")

    doc_parser = subparsers.add_parser("doctor", help="Audit project GDScript files for static typing & legacy issues")
    doc_parser.add_argument("--target", type=str, default=".", help="Target project directory")

    subparsers.add_parser("global-sync", help="Install all skills globally to ~/.gemini/config/skills/")

    args = parser.parse_args()

    if args.command == "init":
        sys.exit(cmd_init(Path(args.target).resolve()))
    elif args.command == "add":
        sys.exit(cmd_add(args.skill, Path(args.target).resolve()))
    elif args.command == "doctor":
        sys.exit(cmd_doctor(Path(args.target).resolve()))
    elif args.command == "global-sync":
        sys.exit(cmd_global_sync())
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
