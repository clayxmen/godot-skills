@tool
class_name GodotSkillRegistry
extends RefCounted

## Registry of all 25 Enterprise Mega Skills & Injectable Component Templates.
## Provides static query methods for AI prompt generation, UI catalog browsing, and node injection.

const CATEGORIES: Array[String] = [
	"All Categories",
	"Architecture & Foundation",
	"Character & Physics",
	"Combat & VFX",
	"AI & Behavior",
	"Data & Persistence",
	"UI/UX & Audio",
	"Optimization & CI/CD"
]

## Returns full metadata for all 25 Godot Mega Skills.
static func get_all_skills() -> Array[Dictionary]:
	return [
		{
			"id": &"godot-architecture-foundation",
			"title": "Architecture Foundation & Clean Design",
			"category": "Architecture & Foundation",
			"description": "Feature-First modular structure, Component-Based Entity Design, Service Locator, and safe AutoLoad governance.",
			"key_classes": ["HealthComponent", "ServiceLocator"],
			"templates": ["HealthComponent.gd", "ServiceLocator.gd"],
			"prompt_hint": "Tổ chức kiến trúc dự án theo Clean Feature-First và Component-Based Entity."
		},
		{
			"id": &"godot-typed-gdscript-mastery",
			"title": "GDScript 2.0 Static Typing Mastery",
			"category": "Architecture & Foundation",
			"description": "100% static typing, Custom Resources (.tres), crash-proof @tool scripts, and zero engine warnings.",
			"key_classes": ["ItemData", "CustomGridGizmo"],
			"templates": ["ItemData.gd", "CustomGridGizmo.gd"],
			"prompt_hint": "Viết script chuẩn GDScript 2.0 Static Typing không warning và dùng Custom Resource."
		},
		{
			"id": &"godot-event-bus-signals",
			"title": "Decoupled Event Bus & Signals",
			"category": "Architecture & Foundation",
			"description": "Enterprise Event Bus with typed signals, one-shot connections, and memory-safe subscription management.",
			"key_classes": ["Events", "SignalListenerComponent"],
			"templates": ["Events.gd", "SignalListenerComponent.gd"],
			"prompt_hint": "Tạo hệ thống Event Bus toàn cục với typed signals để giao tiếp giữa gameplay và UI."
		},
		{
			"id": &"godot-character-controllers",
			"title": "2D/3D Precision Character Controllers",
			"category": "Character & Physics",
			"description": "2D platformer physics (coyote time, jump buffer, wall slide) and 3D Kinematic FPS/TPS movement.",
			"key_classes": ["PlatformerController2D", "CharacterController3D"],
			"templates": ["PlatformerController2D.gd", "CharacterController3D.gd"],
			"prompt_hint": "Tạo CharacterBody2D platformer mượt mà có coyote time và jump buffering."
		},
		{
			"id": &"godot-state-machine-hsm",
			"title": "Hierarchical State Machine (HSM / FSM)",
			"category": "Character & Physics",
			"description": "Typed state transitions, enter/exit hooks, pushdown history stacks, and visual state debugging overlays.",
			"key_classes": ["StateMachine", "State", "PlayerIdleState"],
			"templates": ["StateMachine.gd", "State.gd", "PlayerIdleState.gd"],
			"prompt_hint": "Xây dựng Finite State Machine / Hierarchical State Machine cho nhân vật."
		},
		{
			"id": &"godot-combat-hitbox-hurtbox",
			"title": "Hitbox & Hurtbox Combat Engine",
			"category": "Combat & VFX",
			"description": "Frame-perfect Hitbox/Hurtbox, typed DamagePayloads, knockback, hitstop freeze-frames, and screen shake trauma.",
			"key_classes": ["HitboxComponent2D", "HurtboxComponent2D", "DamagePayload", "ScreenShakeDirector"],
			"templates": ["HitboxComponent2D.gd", "HurtboxComponent2D.gd", "DamagePayload.gd", "ScreenShakeDirector.gd"],
			"prompt_hint": "Tạo hệ thống chiến đấu Hitbox/Hurtbox với DamagePayload và freeze-frame hitstop."
		},
		{
			"id": &"godot-vfx-particles",
			"title": "High-Impact VFX & GPU Particles",
			"category": "Combat & VFX",
			"description": "GPUParticles2D/3D systems, ParticleProcessMaterial physics, sub-emitters, trails, and zero-stutter VFX object pooling.",
			"key_classes": ["ImpactVFXPool", "VFXSpawnerComponent"],
			"templates": ["ImpactVFXPool.gd", "VFXSpawnerComponent.gd"],
			"prompt_hint": "Tạo hiệu ứng nổ và particle VFX pool mượt mà không drop FPS."
		},
		{
			"id": &"godot-shader-development",
			"title": "Custom 2D/3D Shader Mastery",
			"category": "Combat & VFX",
			"description": "Noise dissolve with edge glow, 2D outline, stylized water with foam, and 3D toon/cel lighting shaders.",
			"key_classes": ["ShaderMaterial"],
			"templates": ["dissolve_burn.gdshader", "outline_2d.gdshader", "stylized_water.gdshader", "toon_shading_3d.gdshader"],
			"prompt_hint": "Viết shader 2D/3D (Dissolve burn, pixel outline, toon shading)."
		},
		{
			"id": &"godot-ai-behavior-trees",
			"title": "Behavior Trees & Sensory Perception",
			"category": "AI & Behavior",
			"description": "BT Composites, Decorators, Action leaves, shared Blackboard memory, vision cone and hearing perception.",
			"key_classes": ["BTNode", "BTSequence", "BTSelector", "Blackboard", "PerceptionComponent2D"],
			"templates": ["BTNode.gd", "BTSequence.gd", "BTSelector.gd", "Blackboard.gd", "PerceptionComponent2D.gd"],
			"prompt_hint": "Lập trình AI Enemy bằng Behavior Tree có Blackboard và Perception vision cone."
		},
		{
			"id": &"godot-utility-ai-goap",
			"title": "GOAP & Utility AI Decision Engine",
			"category": "AI & Behavior",
			"description": "Goal-Oriented Action Planning (A* graph search), precondition-effect chaining, and non-linear utility curves.",
			"key_classes": ["GOAPPlanner", "GOAPAction", "GOAPGoal", "UtilityCurve"],
			"templates": ["GOAPPlanner.gd", "GOAPAction.gd", "GOAPGoal.gd", "UtilityCurve.gd"],
			"prompt_hint": "Xây dựng AI thông minh tự lập kế hoạch bằng GOAP và Utility AI."
		},
		{
			"id": &"godot-navigation-server",
			"title": "NavigationServer2D/3D & Avoidance",
			"category": "AI & Behavior",
			"description": "NavigationAgent2D/3D, RVO2 dynamic obstacle avoidance, runtime NavMesh baking for procedural maps.",
			"key_classes": ["NavAgentController2D", "NavAgentController3D", "RuntimeNavMeshBaker"],
			"templates": ["NavAgentController2D.gd", "NavAgentController3D.gd", "RuntimeNavMeshBaker.gd"],
			"prompt_hint": "Cấu hình AI tìm đường NavigationAgent2D với RVO2 avoidance và runtime baking."
		},
		{
			"id": &"godot-inventory-item-system",
			"title": "Data-Driven Inventory & Loot Tables",
			"category": "Data & Persistence",
			"description": "Slot-based inventory, auto-stacking, item splitting, equipment manager, and weighted probability loot drops.",
			"key_classes": ["InventoryComponent", "InventorySlot", "LootTable"],
			"templates": ["InventoryComponent.gd", "InventorySlot.gd", "LootTable.gd"],
			"prompt_hint": "Tạo túi đồ Inventory slot-based có stacking, split và loot table rơi đồ."
		},
		{
			"id": &"godot-save-persistence-security",
			"title": "Encrypted Save & Crash-Safe Persistence",
			"category": "Data & Persistence",
			"description": "AES-256 encrypted saves, SHA-256 anti-tamper checksum, atomic write swapping, and multi-slot save manager.",
			"key_classes": ["SaveManager", "SaveDataPayload"],
			"templates": ["SaveManager.gd", "SaveDataPayload.gd"],
			"prompt_hint": "Lập trình hệ thống lưu file game Save/Load mã hóa AES-256 chống cheat và chống corrupt."
		},
		{
			"id": &"godot-resource-data-tables",
			"title": "Custom Resource Data Tables & CSV Importer",
			"category": "Data & Persistence",
			"description": "Typed DataTable containers, O(1) primary key lookups, and automated CSV/JSON to .tres batch conversion.",
			"key_classes": ["DataTable", "CSVResourceImporter"],
			"templates": ["DataTable.gd", "CSVResourceImporter.gd"],
			"prompt_hint": "Tạo bảng dữ liệu DataTable từ CSV tự động parse sang Resource .tres."
		},
		{
			"id": &"godot-sqlite-local-db",
			"title": "Local SQLite Relational Database",
			"category": "Data & Persistence",
			"description": "Offline relational SQLite database, schema migrations, parameterized queries, and ACID batch transactions.",
			"key_classes": ["SQLiteDatabaseService", "DatabaseMigrationManager"],
			"templates": ["SQLiteDatabaseService.gd", "DatabaseMigrationManager.gd"],
			"prompt_hint": "Tích hợp SQLite local database cho Godot với schema migration và query an toàn."
		},
		{
			"id": &"godot-procedural-generation",
			"title": "Procedural Generation (BSP, Caves, Terrain)",
			"category": "Data & Persistence",
			"description": "BSP dungeon generator (rooms & corridors), cellular automata cave networks, and multi-octave noise terrain.",
			"key_classes": ["BSPDungeonGenerator", "CellularAutomataCaveGenerator", "NoiseTerrainGenerator"],
			"templates": ["BSPDungeonGenerator.gd", "CellularAutomataCaveGenerator.gd", "NoiseTerrainGenerator.gd"],
			"prompt_hint": "Sinh bản đồ ngục tối ngẫu nhiên bằng thuật toán BSP hoặc Cellular Automata."
		},
		{
			"id": &"godot-ui-ux-design-system",
			"title": "Responsive UI/UX & Neobrutalism Tokens",
			"category": "UI/UX & Audio",
			"description": "Multi-resolution responsive layouts, gamepad/keyboard focus navigation, Neobrutalism tactile button widgets.",
			"key_classes": ["UIFocusNavigator", "NeobrutalismButton"],
			"templates": ["UIFocusNavigator.gd", "NeobrutalismButton.gd"],
			"prompt_hint": "Thiết kế giao diện UI responsive hỗ trợ điều hướng Gamepad và phím."
		},
		{
			"id": &"godot-hud-minimap-camera",
			"title": "HUD, Radar Minimap & Dynamic Camera",
			"category": "UI/UX & Audio",
			"description": "Floating damage numbers, radar minimap with blips, and multi-target dynamic framing camera controller.",
			"key_classes": ["FloatingDamageNumberSpawner", "MinimapRadar2D", "SmartCameraController2D"],
			"templates": ["FloatingDamageNumberSpawner.gd", "MinimapRadar2D.gd", "SmartCameraController2D.gd"],
			"prompt_hint": "Thêm hiệu ứng số sát thương bay (Floating Numbers) và Radar Minimap 2D."
		},
		{
			"id": &"godot-audio-engine",
			"title": "Dynamic Audio Director & Sound Pooling",
			"category": "UI/UX & Audio",
			"description": "Audio Bus routing, dynamic BGM crossfading, zero-allocation sound effect pools with pitch jitter, and ducking.",
			"key_classes": ["AudioDirector", "SoundPool"],
			"templates": ["AudioDirector.gd", "SoundPool.gd"],
			"prompt_hint": "Quản lý âm thanh với BGM crossfade mượt mà và Sound Effect Pool ngẫu nhiên pitch."
		},
		{
			"id": &"godot-dialogue-quest-engine",
			"title": "Branching Dialogue & Quest Engine",
			"category": "UI/UX & Audio",
			"description": "Branching NPC conversations, speaker portraits, typewriter speed, and quest state machine with event tracking.",
			"key_classes": ["QuestManager", "DialogueNode", "QuestResource"],
			"templates": ["QuestManager.gd", "DialogueNode.gd", "QuestResource.gd"],
			"prompt_hint": "Tạo hệ thống hội thoại phân nhánh và theo dõi nhiệm vụ Quest Log."
		},
		{
			"id": &"godot-input-gamepad-remapping",
			"title": "Input Remapping & Action Buffering",
			"category": "UI/UX & Audio",
			"description": "Runtime Key/Gamepad button rebinding, user config persistence, dynamic input prompts, and frame-accurate buffer.",
			"key_classes": ["InputRebindManager", "InputBufferComponent"],
			"templates": ["InputRebindManager.gd", "InputBufferComponent.gd"],
			"prompt_hint": "Tạo menu đổi nút phím/tay cầm và Input Buffer chống miss đòn."
		},
		{
			"id": &"godot-multiplayer-high-level",
			"title": "High-Level Multiplayer & Networking",
			"category": "Architecture & Foundation",
			"description": "Server-authoritative networking, ENet/WebSocket peers, @rpc decorators, prediction and server reconciliation.",
			"key_classes": ["NetworkManager", "NetworkPlayerController"],
			"templates": ["NetworkManager.gd", "NetworkPlayerController.gd"],
			"prompt_hint": "Lập trình server-authoritative multiplayer với MultiplayerSpawner và @rpc."
		},
		{
			"id": &"godot-performance-profiling",
			"title": "Performance Profiling & MultiMesh Optimization",
			"category": "Optimization & CI/CD",
			"description": "MultiMeshInstance mass batching (50k+ entities in 1 draw call), server bypasses, and threaded scene loader.",
			"key_classes": ["MultiMeshBulletManager2D", "PerformanceMonitorOverlay", "ThreadedSceneLoader"],
			"templates": ["MultiMeshBulletManager2D.gd", "PerformanceMonitorOverlay.gd", "ThreadedSceneLoader.gd"],
			"prompt_hint": "Tối ưu hiệu năng 50.000 đạn bằng MultiMeshInstance2D và threaded level loader."
		},
		{
			"id": &"godot-testing-gut-tdd",
			"title": "Unit & Integration Testing with GUT",
			"category": "Optimization & CI/CD",
			"description": "GutTest test suites, signal watching, asynchronous assertions, scene testing, and headless CLI test runner.",
			"key_classes": ["test_health_component", "test_inventory_component"],
			"templates": ["test_health_component.gd", "test_inventory_component.gd", "run_gut_tests.ps1"],
			"prompt_hint": "Viết bộ unit test TDD bằng GUT cho HealthComponent và InventoryComponent."
		},
		{
			"id": &"godot-ci-cd-export-automation",
			"title": "Automated Headless Export & CI/CD Pipeline",
			"category": "Optimization & CI/CD",
			"description": "GitHub Actions multi-platform matrix builds, automated GUT test gating, and itch.io Butler deployment.",
			"key_classes": ["export_game"],
			"templates": ["export_game.ps1"],
			"prompt_hint": "Thiết lập CI/CD GitHub Actions build tự động Windows/Linux/Web và push lên Itch.io."
		}
	]

## Returns quick-injectable components for in-editor scene assembly.
static func get_injectable_components() -> Array[Dictionary]:
	return [
		{
			"id": &"health_component",
			"name": "HealthComponent",
			"category": "Combat",
			"node_type": "Node",
			"script_file": "HealthComponent.gd",
			"dest_path": "res://src/components/HealthComponent.gd",
			"description": "Quản lý máu (HP, Max HP, Shield), phát tín hiệu health_changed / died, xử lý hồi máu và trừ máu."
		},
		{
			"id": &"hitbox_component_2d",
			"name": "HitboxComponent2D",
			"category": "Combat",
			"node_type": "Area2D",
			"script_file": "HitboxComponent2D.gd",
			"dest_path": "res://src/components/HitboxComponent2D.gd",
			"description": "Gây sát thương lên Hurtbox đối phương qua DamagePayload với knockback và freeze frame."
		},
		{
			"id": &"hurtbox_component_2d",
			"name": "HurtboxComponent2D",
			"category": "Combat",
			"node_type": "Area2D",
			"script_file": "HurtboxComponent2D.gd",
			"dest_path": "res://src/components/HurtboxComponent2D.gd",
			"description": "Nhận sát thương từ Hitbox, kích hoạt thời gian bất tử (i-frames) và gọi HealthComponent."
		},
		{
			"id": &"state_machine",
			"name": "StateMachine",
			"category": "Behavior",
			"node_type": "Node",
			"script_file": "StateMachine.gd",
			"dest_path": "res://src/components/StateMachine.gd",
			"description": "Bộ quản lý trạng thái phân cấp (FSM/HSM), chuyển đổi state có type-safe và lưu history."
		},
		{
			"id": &"input_buffer_component",
			"name": "InputBufferComponent",
			"category": "Controls",
			"node_type": "Node",
			"script_file": "InputBufferComponent.gd",
			"dest_path": "res://src/components/InputBufferComponent.gd",
			"description": "Bộ nhớ đệm phím bấm (Action buffering) giúp nhân vật không bị trượt đòn đánh khi đang animation."
		},
		{
			"id": &"inventory_component",
			"name": "InventoryComponent",
			"category": "Data",
			"node_type": "Node",
			"script_file": "InventoryComponent.gd",
			"dest_path": "res://src/components/InventoryComponent.gd",
			"description": "Quản lý túi đồ slot-based, tự động stack item, chia stack, giới hạn trọng lượng và lưu trữ."
		},
		{
			"id": &"vfx_spawner_component",
			"name": "VFXSpawnerComponent",
			"category": "Combat",
			"node_type": "Node2D",
			"script_file": "VFXSpawnerComponent.gd",
			"dest_path": "res://src/components/VFXSpawnerComponent.gd",
			"description": "Sinh hiệu ứng va chạm / nổ qua ImpactVFXPool không phân mảnh bộ nhớ."
		},
		{
			"id": &"floating_damage_numbers",
			"name": "FloatingDamageNumberSpawner",
			"category": "UI/UX",
			"node_type": "Node2D",
			"script_file": "FloatingDamageNumberSpawner.gd",
			"dest_path": "res://src/components/FloatingDamageNumberSpawner.gd",
			"description": "Hiển thị số sát thương nhảy (Damage Numbers), đòn chí mạng màu đỏ và hồi máu màu xanh."
		},
		{
			"id": &"smart_camera_controller_2d",
			"name": "SmartCameraController2D",
			"category": "Camera",
			"node_type": "Camera2D",
			"script_file": "SmartCameraController2D.gd",
			"dest_path": "res://src/components/SmartCameraController2D.gd",
			"description": "Camera 2D thông minh bám theo nhiều mục tiêu, zoom tự động theo khoảng cách và chống rung."
		},
		{
			"id": &"perception_component_2d",
			"name": "PerceptionComponent2D",
			"category": "AI",
			"node_type": "Node2D",
			"script_file": "PerceptionComponent2D.gd",
			"dest_path": "res://src/components/PerceptionComponent2D.gd",
			"description": "Thành phần giác quan AI 2D với nón tầm nhìn (Vision Cone), bán kính nghe và mức độ cảnh giác."
		}
	]

## Queries a skill by its unique StringName ID.
static func get_skill_by_id(skill_id: StringName) -> Dictionary:
	for skill: Dictionary in get_all_skills():
		if (skill.get("id") as StringName) == skill_id:
			return skill
	return {}

## Queries skills matching a specific category name.
static func get_skills_by_category(category_name: String) -> Array[Dictionary]:
	if category_name == "All Categories" or category_name.is_empty():
		return get_all_skills()
	var result: Array[Dictionary] = []
	for skill: Dictionary in get_all_skills():
		if (skill.get("category") as String) == category_name:
			result.append(skill)
	return result
