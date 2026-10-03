@tool
class_name GodotCurriculumRegistry
extends RefCounted

## Master Curriculum & Engineering Learning Roadmap for Godot 4.x.
## Maps educational levels (Beginner -> Intermediate -> Advanced -> Master) to the 25 Mega Skills.

## Returns metadata and milestones for all 4 curriculum levels.
static func get_all_levels() -> Array[Dictionary]:
	return [
		{
			"level": 1,
			"name": "🟢 Level 1: Foundation & Basics",
			"duration": "2 - 3 Weeks",
			"focus": "Node & Scene Tree, GDScript 2.0 Static Typing, CharacterBody2D, Typed Signals, UI Containers, Audio Buses.",
			"capstone": "2D Pixel Coin Runner",
			"skills": ["godot-typed-gdscript-mastery", "godot-event-bus-signals", "godot-ui-ux-design-system"],
			"prompt_hint": "Hướng dẫn tôi học Level 1 (Nền tảng Godot 4 & GDScript 2.0 static typing) kèm bài tập thực hành."
		},
		{
			"level": 2,
			"name": "🟡 Level 2: Intermediate & Architecture",
			"duration": "4 - 6 Weeks",
			"focus": "Component Architecture, Hierarchical State Machine (HSM), Combat Juice, Hitbox/Hurtbox, Custom Resources, Inventory, NavigationServer2D.",
			"capstone": "2D Top-Down ARPG Dungeon Slayer",
			"skills": ["godot-architecture-foundation", "godot-character-controllers", "godot-state-machine-hsm", "godot-combat-hitbox-hurtbox", "godot-inventory-item-system", "godot-navigation-server", "godot-hud-minimap-camera", "godot-dialogue-quest-engine"],
			"prompt_hint": "Hướng dẫn tôi học Level 2 (Kiến trúc Component-Based, State Machine, Combat Hitbox/Hurtbox) kèm dự án ARPG."
		},
		{
			"level": 3,
			"name": "🟠 Level 3: Advanced & Systems Engineering",
			"duration": "6 - 8 Weeks",
			"focus": "AI Behavior Trees, GOAP, Custom 2D/3D Shaders, GPU VFX Object Pooling, Procedural Generation (BSP/Caves), 3D Kinematic, SQLite, AES-256 Encrypted Saves.",
			"capstone": "Procedural Roguelike Survival 2D/3D",
			"skills": ["godot-ai-behavior-trees", "godot-utility-ai-goap", "godot-shader-development", "godot-vfx-particles", "godot-procedural-generation", "godot-save-persistence-security", "godot-sqlite-local-db", "godot-input-gamepad-remapping"],
			"prompt_hint": "Hướng dẫn tôi học Level 3 (AI Behavior Trees, Shaders, Procedural Generation, Save mã hóa AES-256) cho game Roguelike."
		},
		{
			"level": 4,
			"name": "🔴 Level 4: Masterclass & Engine Architecture",
			"duration": "8 - 12 Weeks",
			"focus": "Server-Authoritative Multiplayer, Prediction & Rollback, MultiMesh 50k Batching, Engine Server Bypasses, GUT TDD, Headless Multi-Platform CI/CD.",
			"capstone": "Production-Ready Online Co-op Arena MMO",
			"skills": ["godot-multiplayer-high-level", "godot-performance-profiling", "godot-testing-gut-tdd", "godot-ci-cd-export-automation"],
			"prompt_hint": "Hướng dẫn tôi học Level 4 (Server-Authoritative Multiplayer, MultiMesh 50k batching, GUT TDD, CI/CD) chuẩn Technical Director."
		}
	]

## Queries a level by its numeric index (1 to 4).
static func get_level(level_number: int) -> Dictionary:
	for lvl: Dictionary in get_all_levels():
		if int(lvl.get("level", 0)) == level_number:
			return lvl
	return {}
