# 🎮 Godot Skills Ecosystem (Godot 4.3+)

> **Enterprise-Grade AI Agent Skills & Architecture Suite for Godot Game Development**  
> Designed & Engineered for **Senior Prompt Developers, AI Game Architects, and Studio Production Teams**.

---

## 🚀 Overview

`godot-skills` is a masterclass repository of specialized **Agent Skills**, clean architectural patterns, 100% type-safe GDScript 2.0 standards, and production-ready components built specifically for **Godot 4.x**.

---

## 📁 Repository Structure

```text
godot-skills/
├── skills/
│   ├── godot-architecture-foundation/      # Feature-First, DDD, Component Composition, Service Locator
│   ├── godot-typed-gdscript-mastery/       # Strict Static Typing, Custom Resources, @tool Gizmos
│   ├── godot-event-bus-signals/            # Decoupled Typed Event Bus, Domain Signals, Async Callbacks
│   ├── godot-character-controllers/        # 2D Precision Platformer & 3D Kinematic FPS/TPS Controllers
│   ├── godot-state-machine-hsm/            # Hierarchical Finite State Machines & Real-time Debugger
│   ├── godot-combat-hitbox-hurtbox/        # Frame-perfect Hitboxes, DamagePayloads, Hitstop & Screen Shake
│   ├── godot-inventory-item-system/        # Data-driven Slots, Auto-stacking, Equipment & Loot Tables
│   ├── godot-dialogue-quest-engine/        # Branching Dialogue, Quest Graphs & Event Bus Trackers
│   ├── godot-ai-behavior-trees/            # Composites, Decorators, Blackboard & Sensory Vision Cones
│   ├── godot-utility-ai-goap/              # A* Goal Action Planning (GOAP) & Sigmoid Utility Curves
│   ├── godot-procedural-generation/        # BSP Dungeon Generators, Cellular Automata & Noise Terrains
│   ├── godot-navigation-server/            # NavigationServer2D/3D, RVO2 Avoidance & Runtime NavMesh Baking
│   ├── godot-shader-development/           # Dissolve, 2D Outlines, 3D Toon/Cel Shading & Stylized Water
│   ├── godot-vfx-particles/                # GPUParticles2D/3D, Sub-emitters, Trails & Impact VFX Pools
│   ├── godot-audio-engine/                 # Dynamic BGM Crossfading, Sound Effect Pooling & Audio Ducking
│   ├── godot-ui-ux-design-system/          # Themes, Containers, Focus Navigation & Neobrutalism Widgets
│   ├── godot-hud-minimap-camera/           # Floating Damage Text, Radar Minimaps & Multi-Target Smart Cameras
│   ├── godot-input-gamepad-remapping/      # InputMap Rebinding, ConfigFile Saves & Action Input Buffers
│   ├── godot-save-persistence-security/    # AES-256 Multi-slot Encrypted Saves & Anti-Tamper Checksums
│   ├── godot-sqlite-local-db/              # Offline Relational SQLite Database & Versioned Migrations
│   ├── godot-resource-data-tables/         # Custom Resource Data Tables & Automated CSV Importers
│   ├── godot-multiplayer-high-level/       # Server-Authoritative Networking, RPCs & Client Prediction
│   ├── godot-testing-gut-tdd/              # GUT Framework TDD, Signal Assertions & Headless Test Runner
│   ├── godot-performance-profiling/        # MultiMesh 50k Batching, Server Bypasses & Threaded Loading
│   └── godot-ci-cd-export-automation/      # GitHub Actions CI/CD Headless Multi-Platform Export & Itch.io Deploy
│
└── project.godot                           # Root Godot 4.x Project configuration
```

---

## 🏛️ Phase 1: Foundation Skills (Completed)

| Skill Name | Core Responsibility | Templates Included |
| :--- | :--- | :--- |
| **[`godot-architecture-foundation`](file:///c:/VPS/Game/godot-skills/skills/godot-architecture-foundation/SKILL.md)** | Clean Architecture, Feature-First structure, Component composition, AutoLoad governance | [`ServiceLocator.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-architecture-foundation/templates/ServiceLocator.gd), [`HealthComponent.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-architecture-foundation/templates/HealthComponent.gd) |
| **[`godot-typed-gdscript-mastery`](file:///c:/VPS/Game/godot-skills/skills/godot-typed-gdscript-mastery/SKILL.md)** | 100% GDScript 2.0 static typing, Custom Resources, Crash-proof `@tool` gizmos | [`ItemData.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-typed-gdscript-mastery/templates/ItemData.gd), [`CustomGridGizmo.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-typed-gdscript-mastery/templates/CustomGridGizmo.gd) |
| **[`godot-event-bus-signals`](file:///c:/VPS/Game/godot-skills/skills/godot-event-bus-signals/SKILL.md)** | Typed Global Event Bus, Domain signal partitioning, Async request-response callbacks | [`Events.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-event-bus-signals/templates/Events.gd), [`SignalListenerComponent.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-event-bus-signals/templates/SignalListenerComponent.gd) |

---

## ⚔️ Phase 2: Core Gameplay & Combat (Completed)

| Skill Name | Core Responsibility | Templates Included |
| :--- | :--- | :--- |
| **[`godot-character-controllers`](file:///c:/VPS/Game/godot-skills/skills/godot-character-controllers/SKILL.md)** | Precision 2D Platformer (Coyote time, Jump buffering, Wall jumps) & 3D Kinematic FPS/TPS | [`PlatformerController2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-character-controllers/templates/PlatformerController2D.gd), [`CharacterController3D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-character-controllers/templates/CharacterController3D.gd) |
| **[`godot-state-machine-hsm`](file:///c:/VPS/Game/godot-skills/skills/godot-state-machine-hsm/SKILL.md)** | Hierarchical Finite State Machine (HSM), Typed transitions, Pushdown stack, Visual Debugger | [`State.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-state-machine-hsm/templates/State.gd), [`StateMachine.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-state-machine-hsm/templates/StateMachine.gd), [`PlayerIdleState.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-state-machine-hsm/templates/PlayerIdleState.gd) |
| **[`godot-combat-hitbox-hurtbox`](file:///c:/VPS/Game/godot-skills/skills/godot-combat-hitbox-hurtbox/SKILL.md)** | Frame-perfect Hitbox/Hurtbox layers, DamagePayload DTO, Freeze-frame Hitstop, Perlin Screen Shake | [`DamagePayload.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-combat-hitbox-hurtbox/templates/DamagePayload.gd), [`HitboxComponent2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-combat-hitbox-hurtbox/templates/HitboxComponent2D.gd), [`HurtboxComponent2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-combat-hitbox-hurtbox/templates/HurtboxComponent2D.gd), [`ScreenShakeDirector.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-combat-hitbox-hurtbox/templates/ScreenShakeDirector.gd) |
| **[`godot-inventory-item-system`](file:///c:/VPS/Game/godot-skills/skills/godot-inventory-item-system/SKILL.md)** | Data-driven Inventory Slots, Auto-stacking, Item splitting, Equipment management, Weighted Loot Tables | [`InventorySlot.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-inventory-item-system/templates/InventorySlot.gd), [`InventoryComponent.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-inventory-item-system/templates/InventoryComponent.gd), [`LootTable.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-inventory-item-system/templates/LootTable.gd) |
| **[`godot-dialogue-quest-engine`](file:///c:/VPS/Game/godot-skills/skills/godot-dialogue-quest-engine/SKILL.md)** | Branching Dialogue trees, NPC interactions, Quest graph progression & Automated Event Bus sync | [`DialogueNode.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-dialogue-quest-engine/templates/DialogueNode.gd), [`QuestResource.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-dialogue-quest-engine/templates/QuestResource.gd), [`QuestManager.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-dialogue-quest-engine/templates/QuestManager.gd) |

---

## 🧠 Phase 3: AI & Procedural Generation (Completed)

| Skill Name | Core Responsibility | Templates Included |
| :--- | :--- | :--- |
| **[`godot-ai-behavior-trees`](file:///c:/VPS/Game/godot-skills/skills/godot-ai-behavior-trees/SKILL.md)** | Composites (Selector/Sequence), Blackboard shared memory, Sensory Vision Cones & Alert Meters | [`BTNode.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ai-behavior-trees/templates/BTNode.gd), [`BTSelector.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ai-behavior-trees/templates/BTSelector.gd), [`BTSequence.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ai-behavior-trees/templates/BTSequence.gd), [`Blackboard.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ai-behavior-trees/templates/Blackboard.gd), [`PerceptionComponent2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ai-behavior-trees/templates/PerceptionComponent2D.gd) |
| **[`godot-utility-ai-goap`](file:///c:/VPS/Game/godot-skills/skills/godot-utility-ai-goap/SKILL.md)** | Goal-Oriented Action Planning (GOAP) A* solver, WorldState graphs & Sigmoid Utility response curves | [`GOAPAction.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-utility-ai-goap/templates/GOAPAction.gd), [`GOAPGoal.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-utility-ai-goap/templates/GOAPGoal.gd), [`GOAPPlanner.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-utility-ai-goap/templates/GOAPPlanner.gd), [`UtilityCurve.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-utility-ai-goap/templates/UtilityCurve.gd) |
| **[`godot-procedural-generation`](file:///c:/VPS/Game/godot-skills/skills/godot-procedural-generation/SKILL.md)** | Binary Space Partitioning (BSP) Dungeon generator, Cellular Automata caves, FastNoiseLite biomes | [`BSPDungeonGenerator.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-procedural-generation/templates/BSPDungeonGenerator.gd), [`CellularAutomataCaveGenerator.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-procedural-generation/templates/CellularAutomataCaveGenerator.gd), [`NoiseTerrainGenerator.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-procedural-generation/templates/NoiseTerrainGenerator.gd) |
| **[`godot-navigation-server`](file:///c:/VPS/Game/godot-skills/skills/godot-navigation-server/SKILL.md)** | Modern NavigationServer2D/3D, RVO2 Dynamic Obstacle Avoidance loops, Runtime NavMesh Rebaking | [`NavAgentController2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-navigation-server/templates/NavAgentController2D.gd), [`NavAgentController3D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-navigation-server/templates/NavAgentController3D.gd), [`RuntimeNavMeshBaker.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-navigation-server/templates/RuntimeNavMeshBaker.gd) |

---

## 🎨 Phase 4: Graphics, Shaders & Audio (Completed)

| Skill Name | Core Responsibility | Templates Included |
| :--- | :--- | :--- |
| **[`godot-shader-development`](file:///c:/VPS/Game/godot-skills/skills/godot-shader-development/SKILL.md)** | Custom `.gdshader` shaders: Noise Dissolve, 2D Pixel Outline, 3D Toon Cel-shading & Stylized Water | [`dissolve_burn.gdshader`](file:///c:/VPS/Game/godot-skills/skills/godot-shader-development/templates/dissolve_burn.gdshader), [`outline_2d.gdshader`](file:///c:/VPS/Game/godot-skills/skills/godot-shader-development/templates/outline_2d.gdshader), [`toon_shading_3d.gdshader`](file:///c:/VPS/Game/godot-skills/skills/godot-shader-development/templates/toon_shading_3d.gdshader), [`stylized_water.gdshader`](file:///c:/VPS/Game/godot-skills/skills/godot-shader-development/templates/stylized_water.gdshader) |
| **[`godot-vfx-particles`](file:///c:/VPS/Game/godot-skills/skills/godot-vfx-particles/SKILL.md)** | GPUParticles2D/3D, ParticleProcessMaterial physics, Sub-emitters (Collision/Death) & VFX Pooling | [`VFXSpawnerComponent.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-vfx-particles/templates/VFXSpawnerComponent.gd), [`ImpactVFXPool.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-vfx-particles/templates/ImpactVFXPool.gd) |
| **[`godot-audio-engine`](file:///c:/VPS/Game/godot-skills/skills/godot-audio-engine/SKILL.md)** | Audio Bus routing architecture, Dynamic BGM Crossfading director, Zero-allocation SFX Sound Pool | [`AudioDirector.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-audio-engine/templates/AudioDirector.gd), [`SoundPool.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-audio-engine/templates/SoundPool.gd) |

---

## 🖥️ Phase 5: UI & Persistence (Completed)

| Skill Name | Core Responsibility | Templates Included |
| :--- | :--- | :--- |
| **[`godot-ui-ux-design-system`](file:///c:/VPS/Game/godot-skills/skills/godot-ui-ux-design-system/SKILL.md)** | Responsive Layouts (Containers/Anchors), Gamepad/Keyboard Focus Navigation & Tactile Button Widgets | [`UIFocusNavigator.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ui-ux-design-system/templates/UIFocusNavigator.gd), [`NeobrutalismButton.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-ui-ux-design-system/templates/NeobrutalismButton.gd) |
| **[`godot-hud-minimap-camera`](file:///c:/VPS/Game/godot-skills/skills/godot-hud-minimap-camera/SKILL.md)** | Parabolic Floating Damage Text, SubViewport 2D/3D Radar Minimaps & Multi-Target Smart Framing Cameras | [`FloatingDamageNumberSpawner.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-hud-minimap-camera/templates/FloatingDamageNumberSpawner.gd), [`MinimapRadar2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-hud-minimap-camera/templates/MinimapRadar2D.gd), [`SmartCameraController2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-hud-minimap-camera/templates/SmartCameraController2D.gd) |
| **[`godot-input-gamepad-remapping`](file:///c:/VPS/Game/godot-skills/skills/godot-input-gamepad-remapping/SKILL.md)** | Runtime InputMap Rebinding (Keyboard/Gamepad), ConfigFile persistence & Frame-Accurate Input Buffering | [`InputRebindManager.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-input-gamepad-remapping/templates/InputRebindManager.gd), [`InputBufferComponent.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-input-gamepad-remapping/templates/InputBufferComponent.gd) |
| **[`godot-save-persistence-security`](file:///c:/VPS/Game/godot-skills/skills/godot-save-persistence-security/SKILL.md)** | AES-256 Multi-slot Encrypted Saves, SHA-256 Anti-Tamper Checksums & Atomic Write Crash Protection | [`SaveDataPayload.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-save-persistence-security/templates/SaveDataPayload.gd), [`SaveManager.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-save-persistence-security/templates/SaveManager.gd) |
| **[`godot-sqlite-local-db`](file:///c:/VPS/Game/godot-skills/skills/godot-sqlite-local-db/SKILL.md)** | Offline Relational SQLite Database, Versioned SQL Schema Migrations & Transaction Batching | [`DatabaseMigrationManager.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-sqlite-local-db/templates/DatabaseMigrationManager.gd), [`SQLiteDatabaseService.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-sqlite-local-db/templates/SQLiteDatabaseService.gd) |
| **[`godot-resource-data-tables`](file:///c:/VPS/Game/godot-skills/skills/godot-resource-data-tables/SKILL.md)** | Custom Resource Data Tables, O(1) Keyed Lookups & Automated CSV-to-Resource Batch Importers | [`DataTable.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-resource-data-tables/templates/DataTable.gd), [`CSVResourceImporter.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-resource-data-tables/templates/CSVResourceImporter.gd) |

---

## 🌐 Phase 6: Multiplayer, Testing & CI/CD (Completed)

| Skill Name | Core Responsibility | Templates Included |
| :--- | :--- | :--- |
| **[`godot-multiplayer-high-level`](file:///c:/VPS/Game/godot-skills/skills/godot-multiplayer-high-level/SKILL.md)** | Server-Authoritative Networking, `@rpc` annotations, MultiplayerSpawner/Synchronizer, Client Prediction | [`NetworkManager.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-multiplayer-high-level/templates/NetworkManager.gd), [`NetworkPlayerController.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-multiplayer-high-level/templates/NetworkPlayerController.gd) |
| **[`godot-testing-gut-tdd`](file:///c:/VPS/Game/godot-skills/skills/godot-testing-gut-tdd/SKILL.md)** | GUT Framework TDD, Signal Watchers/Assertions, Scene Test Automation & Headless CLI Test Runner | [`test_health_component.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-testing-gut-tdd/templates/test_health_component.gd), [`test_inventory_component.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-testing-gut-tdd/templates/test_inventory_component.gd), [`run_gut_tests.ps1`](file:///c:/VPS/Game/godot-skills/skills/godot-testing-gut-tdd/templates/run_gut_tests.ps1) |
| **[`godot-performance-profiling`](file:///c:/VPS/Game/godot-skills/skills/godot-performance-profiling/SKILL.md)** | MultiMeshInstance 50k+ Batching, Server Bypasses, Background Threaded Streaming & In-Game FPS Monitor | [`MultiMeshBulletManager2D.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-performance-profiling/templates/MultiMeshBulletManager2D.gd), [`ThreadedSceneLoader.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-performance-profiling/templates/ThreadedSceneLoader.gd), [`PerformanceMonitorOverlay.gd`](file:///c:/VPS/Game/godot-skills/skills/godot-performance-profiling/templates/PerformanceMonitorOverlay.gd) |
| **[`godot-ci-cd-export-automation`](file:///c:/VPS/Game/godot-skills/skills/godot-ci-cd-export-automation/SKILL.md)** | GitHub Actions Matrix CI/CD, Headless Multi-Platform Export (Win/Linux/Mac/Web/Android) & Itch.io Deploy | [`github_ci_cd_workflow.yml`](file:///c:/VPS/Game/godot-skills/skills/godot-ci-cd-export-automation/templates/github_ci_cd_workflow.yml), [`export_presets.cfg.template`](file:///c:/VPS/Game/godot-skills/skills/godot-ci-cd-export-automation/templates/export_presets.cfg.template), [`export_game.ps1`](file:///c:/VPS/Game/godot-skills/skills/godot-ci-cd-export-automation/templates/export_game.ps1) |

---

## 🎯 Master Plan Roadmap: 100% COMPLETE!

- [x] **Phase 1: Foundation** (`godot-architecture-foundation`, `godot-typed-gdscript-mastery`, `godot-event-bus-signals`)
- [x] **Phase 2: Core Gameplay & Combat** (`godot-character-controllers`, `godot-state-machine-hsm`, `godot-combat-hitbox-hurtbox`, `godot-inventory-item-system`, `godot-dialogue-quest-engine`)
- [x] **Phase 3: AI & Procedural Generation** (`godot-ai-behavior-trees`, `godot-utility-ai-goap`, `godot-procedural-generation`, `godot-navigation-server`)
- [x] **Phase 4: Graphics, Shaders & Audio** (`godot-shader-development`, `godot-vfx-particles`, `godot-audio-engine`)
- [x] **Phase 5: UI & Persistence** (`godot-ui-ux-design-system`, `godot-hud-minimap-camera`, `godot-input-gamepad-remapping`, `godot-save-persistence-security`, `godot-sqlite-local-db`, `godot-resource-data-tables`)
- [x] **Phase 6: Multiplayer, Testing & CI/CD** (`godot-multiplayer-high-level`, `godot-testing-gut-tdd`, `godot-performance-profiling`, `godot-ci-cd-export-automation`)
