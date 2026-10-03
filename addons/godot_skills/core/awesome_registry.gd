@tool
class_name GodotAwesomeRegistry
extends RefCounted

## Curated registry of premier Godot 4.x resources, production addons, masterclass tutorials,
## shader libraries, game math algorithms, and CC0 asset repositories.

const AWESOME_CATEGORIES: Array[String] = [
	"All Resources",
	"Official & Docs",
	"Top Addons & Frameworks",
	"Learning & Masterclasses",
	"Shaders & Graphics",
	"Math & Algorithms",
	"Free Assets & Audio",
	"Open Source Demos"
]

## Returns the complete curated directory of awesome Godot resources.
static func get_all_resources() -> Array[Dictionary]:
	return [
		# --- OFFICIAL & DOCS ---
		{
			"id": &"godot_docs",
			"title": "Official Godot 4 Documentation",
			"author": "Godot Engine Foundation",
			"category": "Official & Docs",
			"tags": ["Docs", "API", "Engine", "Official"],
			"url": "https://docs.godotengine.org/en/stable/",
			"description": "Comprehensive reference manuals, step-by-step beginner guides, and full class reference for Godot 4.x.",
			"ai_prompt": "Search the official Godot 4 documentation for best practices and API changes regarding [TOPIC]."
		},
		{
			"id": &"gdscript_reference",
			"title": "GDScript 2.0 Language Reference",
			"author": "Godot Engine",
			"category": "Official & Docs",
			"tags": ["GDScript", "Static Typing", "Reference"],
			"url": "https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html",
			"description": "Authoritative guide to GDScript 2.0 static typing, annotations (@export, @onready, @rpc), lambdas, and coroutines.",
			"ai_prompt": "Explain how GDScript 2.0 static typing and annotations work in Godot 4 with code examples."
		},
		{
			"id": &"godot_proposals",
			"title": "Godot Improvement Proposals (GIP)",
			"author": "Godot Community & Core Devs",
			"category": "Official & Docs",
			"tags": ["RFC", "Roadmap", "Features", "GitHub"],
			"url": "https://github.com/godotengine/godot-proposals",
			"description": "Community-driven feature requests and engineering discussions shaping future versions of Godot Engine.",
			"ai_prompt": "What are the latest Godot proposals and roadmap discussions regarding [FEATURE]?"
		},
		{
			"id": &"godot_engine_repo",
			"title": "Godot Engine Source Code (C++)",
			"author": "Godot Contributors",
			"category": "Official & Docs",
			"tags": ["C++", "Source", "Core", "GitHub"],
			"url": "https://github.com/godotengine/godot",
			"description": "Complete open-source C++ codebase of Godot Engine. Essential for GDExtension and core engine research.",
			"ai_prompt": "How is [NODE/SERVER] implemented in Godot Engine C++ source code?"
		},

		# --- TOP ADDONS & FRAMEWORKS ---
		{
			"id": &"phantom_camera",
			"title": "Phantom Camera",
			"author": "Marcus Sprenger (Ramok)",
			"category": "Top Addons & Frameworks",
			"tags": ["Camera", "Cinemachine", "2D/3D", "Juice"],
			"url": "https://github.com/ramok/phantom-camera",
			"description": "Cinemachine-style camera director for Godot 4. Seamless transitions, deadzones, noise shakes, multi-target framing.",
			"ai_prompt": "How do I setup Phantom Camera 2D/3D in Godot 4 for smooth camera transitions and player framing?"
		},
		{
			"id": &"dialogic",
			"title": "Dialogic 2.0",
			"author": "Jowan-Spooner & Dialogic Team",
			"category": "Top Addons & Frameworks",
			"tags": ["Dialogue", "Narrative", "Visual", "Quests"],
			"url": "https://github.com/dialogic-godot/dialogic",
			"description": "Premier visual branching dialogue system for Godot 4. Visual timeline graph, portraits, variables, audio integration.",
			"ai_prompt": "How do I create branching dialogue trees and custom layouts with Dialogic 2 in Godot 4?"
		},
		{
			"id": &"gut_testing",
			"title": "GUT (Godot Unit Testing)",
			"author": "Tom 'bitwes' Pohl",
			"category": "Top Addons & Frameworks",
			"tags": ["Testing", "TDD", "CI/CD", "Unit Tests"],
			"url": "https://github.com/bitwes/Gut",
			"description": "Full-featured automated testing framework for Godot 4. Unit tests, integration tests, signal assertions, CLI runner.",
			"ai_prompt": "Write a GUT test suite in Godot 4 with signal watching and async assertions for [COMPONENT]."
		},
		{
			"id": &"beehave",
			"title": "Beehave (Behavior Trees)",
			"author": "bitwes",
			"category": "Top Addons & Frameworks",
			"tags": ["AI", "Behavior Trees", "Stealth", "NPC"],
			"url": "https://github.com/bitwes/beehave",
			"description": "Visual, modular Behavior Tree plugin for Godot 4. Includes Composites, Decorators, Leaves, and Blackboard memory.",
			"ai_prompt": "How do I build an AI Enemy decision tree using Beehave behavior trees in Godot 4?"
		},
		{
			"id": &"limbo_ai",
			"title": "LimboAI (C++ GDExtension AI)",
			"author": "Limbonaut",
			"category": "Top Addons & Frameworks",
			"tags": ["AI", "GDExtension", "HSM", "High Performance"],
			"url": "https://github.com/limbonaut/limboai",
			"description": "High-performance C++ Behavior Tree and Hierarchical State Machine addon with in-editor visual debugger.",
			"ai_prompt": "Compare LimboAI and GDScript state machines for large-scale enemy AI in Godot 4."
		},
		{
			"id": &"godot_jolt",
			"title": "Godot Jolt (Physics Engine)",
			"author": "jrouwe & Godot Jolt Team",
			"category": "Top Addons & Frameworks",
			"tags": ["Physics", "3D", "Jolt", "Performance"],
			"url": "https://github.com/godot-jolt/godot-jolt",
			"description": "Multi-threaded Jolt Physics replacement for Godot 3D. 5x-10x performance boost for complex ragdolls and colliders.",
			"ai_prompt": "How do I install and configure Godot Jolt physics for high-performance 3D ragdoll simulations?"
		},
		{
			"id": &"godot_rapier",
			"title": "Godot Rapier 2D/3D",
			"author": "appsinacup",
			"category": "Top Addons & Frameworks",
			"tags": ["Physics", "Rust", "Deterministic", "Rapier"],
			"url": "https://github.com/appsinacup/godot-rapier-2d",
			"description": "Deterministic, cross-platform 2D/3D physics engine powered by Rust's Rapier. Ideal for rollback netcode.",
			"ai_prompt": "How can I set up deterministic 2D physics using Godot Rapier for multiplayer lockstep?"
		},
		{
			"id": &"terrain_3d",
			"title": "Terrain3D",
			"author": "Tokisan Games",
			"category": "Top Addons & Frameworks",
			"tags": ["3D", "Terrain", "Voxel", "Open World"],
			"url": "https://github.com/TokisanGames/Terrain3D",
			"description": "High-performance, C++ editable 3D terrain system for Godot 4. Supports large maps, foliage painting, and multi-texturing.",
			"ai_prompt": "How do I sculpt and texture open-world landscapes using Terrain3D in Godot 4?"
		},
		{
			"id": &"netfox",
			"title": "Netfox Multiplayer Tools",
			"author": "foxssake",
			"category": "Top Addons & Frameworks",
			"tags": ["Multiplayer", "Rollback", "Prediction", "Network"],
			"url": "https://github.com/foxssake/netfox",
			"description": "Comprehensive client-side prediction, server reconciliation, interpolation, and rollback toolkit for Godot 4.",
			"ai_prompt": "Explain client-side prediction and server reconciliation workflow in Godot 4 with Netfox."
		},
		{
			"id": &"godotsteam",
			"title": "GodotSteam",
			"author": "Gramps / GodotSteam",
			"category": "Top Addons & Frameworks",
			"tags": ["Steam", "Achievements", "Lobby", "Commercial"],
			"url": "https://github.com/GodotSteam/GodotSteam",
			"description": "Full Steamworks API wrapper for Godot. Supports achievements, Steam Input, cloud saves, lobbies, and P2P networking.",
			"ai_prompt": "How do I integrate Steam achievements and Cloud Saves into Godot 4 using GodotSteam?"
		},

		# --- LEARNING & MASTERCLASSES ---
		{
			"id": &"gdquest",
			"title": "GDQuest Open Source & Courses",
			"author": "Nathan Lovato & GDQuest Team",
			"category": "Learning & Masterclasses",
			"tags": ["Architecture", "Tutorials", "Free", "Clean Code"],
			"url": "https://www.gdquest.com/",
			"description": "Top learning hub for Godot: 2D/3D architecture, Tour of GDScript interactive app, and design pattern masterclasses.",
			"ai_prompt": "What are GDQuest's recommended clean architecture practices for Godot 4 game structure?"
		},
		{
			"id": &"godot_recipes",
			"title": "KidsCanCode Godot 4 Recipes",
			"author": "Chris Bradfield (KidsCanCode)",
			"category": "Learning & Masterclasses",
			"tags": ["Recipes", "Math", "Steering", "Basics"],
			"url": "https://kidscancode.org/godot_recipes/4.x/",
			"description": "Practical step-by-step game development recipes: math formulas, steering behaviors, grid movement, and procedural caves.",
			"ai_prompt": "Provide a Godot 4 recipe for Context-Based Steering Behaviors (avoidance and seeking)."
		},
		{
			"id": &"clear_code",
			"title": "Clear Code Masterclasses",
			"author": "Clear Code (YouTube)",
			"category": "Learning & Masterclasses",
			"tags": ["YouTube", "Complete Guide", "Video", "Beginner to Advanced"],
			"url": "https://www.youtube.com/@ClearCode",
			"description": "Comprehensive 10+ hour deep dive video courses on Godot 4 2D, 3D, GDScript, physics, and full game projects.",
			"ai_prompt": "Summarize the key architectural lessons from Clear Code's Godot 4 master tutorials."
		},
		{
			"id": &"game_prog_patterns",
			"title": "Game Programming Patterns",
			"author": "Robert Nystrom",
			"category": "Learning & Masterclasses",
			"tags": ["Patterns", "Architecture", "Design", "Classic"],
			"url": "https://gameprogrammingpatterns.com/",
			"description": "The definitive book on game architecture design patterns (Command, Flyweight, Observer, State, Component, Subsystem).",
			"ai_prompt": "How can I implement the Command Pattern with Undo/Redo in GDScript 2.0?"
		},

		# --- SHADERS & GRAPHICS ---
		{
			"id": &"godot_shaders_hub",
			"title": "GodotShaders.com Community Hub",
			"author": "GodotShaders Community",
			"category": "Shaders & Graphics",
			"tags": ["Shaders", "GLSL", "VFX", "Materials"],
			"url": "https://godotshaders.com/",
			"description": "Over 1,000+ free custom 2D and 3D shaders: pixel art outlines, water foam, noise dissolve, cel shading, post-processing.",
			"ai_prompt": "Write a 2D Godot 4 shader with pixel-perfect outline and chromatic aberration."
		},
		{
			"id": &"book_of_shaders",
			"title": "The Book of Shaders",
			"author": "Patricio Gonzalez Vivo & Jen Lowe",
			"category": "Shaders & Graphics",
			"tags": ["GLSL", "Math", "Fractals", "Generative"],
			"url": "https://thebookofshaders.com/",
			"description": "Step-by-step visual tutorial on fragment shaders, generative patterns, noise functions, and procedural textures.",
			"ai_prompt": "How do I implement Simplex Noise and Voronoi cellular noise in Godot 4 visual shaders?"
		},
		{
			"id": &"inigo_quilez_math",
			"title": "Inigo Quilez Graphics Math & SDFs",
			"author": "Inigo Quilez",
			"category": "Shaders & Graphics",
			"tags": ["SDF", "Math", "Raymarching", "Lighting"],
			"url": "https://iquilezles.org/",
			"description": "World-renowned reference for Signed Distance Functions (2D/3D SDFs), procedural lighting, and raymarching math.",
			"ai_prompt": "How do I compute 2D/3D Signed Distance Fields (SDFs) in Godot 4 spatial shaders?"
		},

		# --- MATH & ALGORITHMS ---
		{
			"id": &"redblob_algorithms",
			"title": "Red Blob Games Interactive Math",
			"author": "Amit Patel (Red Blob Games)",
			"category": "Math & Algorithms",
			"tags": ["Hex Grids", "A*", "Pathfinding", "Noise"],
			"url": "https://www.redblobgames.com/",
			"description": "Visual, interactive mathematical guides for Hexagonal Grids, A* Pathfinding, Line of Sight, and 2D Terrain Generation.",
			"ai_prompt": "How do I convert axial hexagonal grid coordinates to Godot Vector2 world positions?"
		},
		{
			"id": &"catlike_coding",
			"title": "Catlike Coding Math Tutorials",
			"author": "Jasper Flick",
			"category": "Math & Algorithms",
			"tags": ["Curves", "Splines", "Mesh Generation", "Math"],
			"url": "https://catlikecoding.com/",
			"description": "In-depth mathematical articles on Bezier curves, procedural mesh generation, matrices, and flow fields.",
			"ai_prompt": "How do I generate a dynamic procedural tube mesh along a Curve3D in Godot 4?"
		},

		# --- FREE ASSETS & AUDIO ---
		{
			"id": &"kenney_assets",
			"title": "Kenney.nl (Free Game Assets)",
			"author": "Kenney (Asset Jesus)",
			"category": "Free Assets & Audio",
			"tags": ["CC0", "Sprites", "3D Models", "Audio", "UI"],
			"url": "https://kenney.nl/",
			"description": "Thousands of free CC0 public domain 2D sprites, 3D low-poly models, UI packs, and sound effect libraries.",
			"ai_prompt": "What are the best Kenney UI and character asset packs to prototype a 2D/3D prototype in Godot?"
		},
		{
			"id": &"opengameart",
			"title": "OpenGameArt.org",
			"author": "OpenGameArt Community",
			"category": "Free Assets & Audio",
			"tags": ["Open Source", "Music", "Textures", "Art"],
			"url": "https://opengameart.org/",
			"description": "Massive repository of open-source 2D sprites, 3D meshes, orchestral music tracks, and UI icons.",
			"ai_prompt": "Recommend search tags and license filters on OpenGameArt for commercial indie game projects."
		},
		{
			"id": &"freesound",
			"title": "Freesound.org Audio Archive",
			"author": "Music Technology Group (UPF)",
			"category": "Free Assets & Audio",
			"tags": ["Audio", "SFX", "Foley", "Creative Commons"],
			"url": "https://freesound.org/",
			"description": "Over 500,000+ Creative Commons audio recordings, foley effects, explosions, UI clicks, and ambient tracks.",
			"ai_prompt": "How do I set up custom AudioBus layout with Reverb and Chorus effects for atmospheric sounds in Godot 4?"
		},
		{
			"id": &"sonniss_gdc",
			"title": "Sonniss GDC Audio Archives",
			"author": "Sonniss",
			"category": "Free Assets & Audio",
			"tags": ["SFX", "Commercial", "Royalty Free", "High Quality"],
			"url": "https://sonniss.com/gameaudioarchive",
			"description": "Over 100+ GB of professional, commercial-grade sound effects released annually for GDC (100% royalty-free).",
			"ai_prompt": "How do I optimize large WAV/OGG audio files for Godot 4 memory and streaming performance?"
		},
		{
			"id": &"lospec",
			"title": "Lospec Pixel Art & Palettes",
			"author": "Lospec Community",
			"category": "Free Assets & Audio",
			"tags": ["Pixel Art", "Palettes", "Color", "Voxel"],
			"url": "https://lospec.com/",
			"description": "Curated retro color palettes (PICO-8, GameBoy, ENDESGA 32), pixel art tutorials, and voxel editors.",
			"ai_prompt": "How do I apply a fixed color palette shader in Godot 4 using a 1D gradient texture?"
		},

		# --- OPEN SOURCE DEMOS ---
		{
			"id": &"godot_demos",
			"title": "Official Godot 4 Demo Projects",
			"author": "Godot Engine",
			"category": "Open Source Demos",
			"tags": ["Demos", "Samples", "2D", "3D", "Physics"],
			"url": "https://github.com/godotengine/godot-demo-projects",
			"description": "Hundreds of official example projects covering 2D platforming, 3D physics, shaders, multiplayer, and UI layouts.",
			"ai_prompt": "Where can I find official Godot 4 sample projects for NavigationAgent3D and MultiMeshInstance3D?"
		},
		{
			"id": &"pixelorama",
			"title": "Pixelorama (Sprite Editor in Godot)",
			"author": "Orama Interactive",
			"category": "Open Source Demos",
			"tags": ["Pixel Art", "Full App", "Tool", "Godot Made"],
			"url": "https://github.com/Orama-Interactive/Pixelorama",
			"description": "Full-featured open-source 2D pixel art and animation editor built 100% in Godot Engine.",
			"ai_prompt": "Study Pixelorama's UI architecture and custom canvas drawing implementation in Godot."
		},
		{
			"id": &"tuxemon",
			"title": "Tuxemon (Open Source Monster RPG)",
			"author": "Tuxemon Team",
			"category": "Open Source Demos",
			"tags": ["RPG", "2D", "Open Source", "Turn-Based"],
			"url": "https://github.com/Tuxemon/Tuxemon",
			"description": "Open-source turn-based monster catching RPG game with modular combat and narrative scripting.",
			"ai_prompt": "How can I architect a turn-based elemental combat system in Godot 4 inspired by classic RPGs?"
		}
	]

## Returns filtered resources by category name.
static func get_resources_by_category(category_name: String) -> Array[Dictionary]:
	if category_name == "All Resources" or category_name.is_empty():
		return get_all_resources()
	var result: Array[Dictionary] = []
	for res: Dictionary in get_all_resources():
		if (res.get("category") as String) == category_name:
			result.append(res)
	return result

## Searches resources by text query (matching title, description, tags, author).
static func search_resources(query: String, category_name: String = "All Resources") -> Array[Dictionary]:
	var q: String = query.strip_edges().to_lower()
	var pool: Array[Dictionary] = get_resources_by_category(category_name)
	if q.is_empty():
		return pool
	
	var result: Array[Dictionary] = []
	for item: Dictionary in pool:
		var title: String = (item.get("title") as String).to_lower()
		var desc: String = (item.get("description") as String).to_lower()
		var author: String = (item.get("author") as String).to_lower()
		var tags: Array = item.get("tags", [])
		var tags_str: String = " ".join(tags).to_lower()

		if title.contains(q) or desc.contains(q) or author.contains(q) or tags_str.contains(q):
			result.append(item)
	return result

## Opens the given resource URL in the default system browser.
static func open_url(url: String) -> void:
	if not url.is_empty():
		OS.shell_open(url)
