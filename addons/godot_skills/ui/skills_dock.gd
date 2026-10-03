@tool
class_name GodotSkillsDock
extends Control

## Editor Dock UI for Godot Skills Suite.
## Provides 1-Click AI Setup, Visual Component Injection, Skills Catalog, Project Doctor, and Godot Awesome Hub.

@onready var tab_container: TabContainer = $VBox/TabContainer

# Tab 1: AI Setup
@onready var ai_status_label: RichTextLabel = $VBox/TabContainer/AISetup/VBox/StatusLabel
@onready var btn_generate_ai: Button = $VBox/TabContainer/AISetup/VBox/BtnGenerateAI
@onready var ai_log_output: RichTextLabel = $VBox/TabContainer/AISetup/VBox/LogOutput

# Tab 2: Components
@onready var comp_container: VBoxContainer = $VBox/TabContainer/Components/Scroll/CompList
@onready var comp_status_label: Label = $VBox/TabContainer/Components/Header/StatusLabel

# Tab 3: Skills Catalog
@onready var skills_category_filter: OptionButton = $VBox/TabContainer/Skills/Header/CategoryOption
@onready var skills_search_input: LineEdit = $VBox/TabContainer/Skills/Header/SearchInput
@onready var skills_list_container: VBoxContainer = $VBox/TabContainer/Skills/Scroll/SkillsList

# Tab 4: Doctor
@onready var btn_run_doctor: Button = $VBox/TabContainer/Doctor/Header/BtnRunDoctor
@onready var doctor_summary_label: RichTextLabel = $VBox/TabContainer/Doctor/Header/SummaryLabel
@onready var doctor_results_tree: Tree = $VBox/TabContainer/Doctor/DoctorTree

# Tab 5: Godot Awesome
@onready var awesome_category_option: OptionButton = $VBox/TabContainer/Awesome/Header/CategoryOption
@onready var awesome_search_input: LineEdit = $VBox/TabContainer/Awesome/Header/SearchInput
@onready var awesome_list_container: VBoxContainer = $VBox/TabContainer/Awesome/Scroll/AwesomeList

var undo_redo: UndoRedo = null

func _ready() -> void:
	if not Engine.is_editor_hint():
		return

	_setup_ai_tab()
	_setup_components_tab()
	_setup_skills_tab()
	_setup_doctor_tab()
	_setup_awesome_tab()

## Sets the undo_redo instance passed from the plugin
func set_undo_redo(p_undo_redo: UndoRedo) -> void:
	undo_redo = p_undo_redo

# ==========================================
# ⚡ TAB 1: AI SETUP
# ==========================================
func _setup_ai_tab() -> void:
	if btn_generate_ai != null and not btn_generate_ai.pressed.is_connected(_on_generate_ai_pressed):
		btn_generate_ai.pressed.connect(_on_generate_ai_pressed)
	_refresh_ai_status()

func _refresh_ai_status() -> void:
	if ai_status_label == null:
		return
	var status: Dictionary = GodotAIContextGenerator.get_ai_status()
	var text: String = "[b]AI Multi-Agent Project Status:[/b]\n"
	text += " • Google Antigravity: " + ("[color=#20df40]Ready (%d skills)[/color]" % status.get("gemini_skills_count", 0) if status.get("gemini", false) else "[color=#ff5555]Not Found[/color]") + "\n"
	text += " • Cursor Rules (.cursor/rules): " + ("[color=#20df40]Configured[/color]" if status.get("cursor", false) else "[color=#ff5555]Not Found[/color]") + "\n"
	text += " • Claude Code (CLAUDE.md): " + ("[color=#20df40]Configured[/color]" if status.get("claude", false) else "[color=#ff5555]Not Found[/color]") + "\n"
	text += " • GitHub Copilot Instructions: " + ("[color=#20df40]Configured[/color]" if status.get("copilot", false) else "[color=#ff5555]Not Found[/color]") + "\n"
	ai_status_label.text = text

func _on_generate_ai_pressed() -> void:
	var result: Dictionary = GodotAIContextGenerator.generate_all_ai_contexts()
	_refresh_ai_status()
	if ai_log_output != null:
		var log_text: String = "[color=#20df40][b]✔ " + String(result.get("message", "")) + "[/b][/color]\n"
		var files: Array = result.get("generated_files", [])
		for f in files:
			log_text += " [color=#00aaff]➜ Created/Updated:[/color] " + String(f) + "\n"
		ai_log_output.text = log_text

# ==========================================
# 🧩 TAB 2: COMPONENT INJECTOR
# ==========================================
func _setup_components_tab() -> void:
	if comp_container == null:
		return
	
	for child in comp_container.get_children():
		child.queue_free()

	var components: Array[Dictionary] = GodotSkillRegistry.get_injectable_components()
	for comp: Dictionary in components:
		var item_panel: PanelContainer = PanelContainer.new()
		var hbox: HBoxContainer = HBoxContainer.new()
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var vbox_info: VBoxContainer = VBoxContainer.new()
		vbox_info.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var title_label: Label = Label.new()
		title_label.text = String(comp.get("name", "")) + " (" + String(comp.get("node_type", "")) + ")"
		title_label.add_theme_font_size_override("font_size", 13)

		var desc_label: Label = Label.new()
		desc_label.text = String(comp.get("description", ""))
		desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		desc_label.add_theme_font_size_override("font_size", 11)
		desc_label.modulate = Color(0.8, 0.8, 0.8, 1.0)

		vbox_info.add_child(title_label)
		vbox_info.add_child(desc_label)

		var btn_inject: Button = Button.new()
		btn_inject.text = "➕ Inject Node"
		btn_inject.custom_minimum_size = Vector2(110.0, 32.0)
		var comp_id: StringName = comp.get("id", &"")
		btn_inject.pressed.connect(_on_inject_component_pressed.bind(comp_id))

		hbox.add_child(vbox_info)
		hbox.add_child(btn_inject)
		item_panel.add_child(hbox)
		comp_container.add_child(item_panel)

func _on_inject_component_pressed(comp_id: StringName) -> void:
	if not Engine.is_editor_hint():
		return

	var target_parent: Node = null
	if EditorInterface.get_edited_scene_root() != null:
		var selected_nodes: Array[Node] = EditorInterface.get_selection().get_selected_nodes()
		if not selected_nodes.is_empty():
			target_parent = selected_nodes[0]
		else:
			target_parent = EditorInterface.get_edited_scene_root()

	if target_parent == null:
		if comp_status_label != null:
			comp_status_label.text = "❌ Error: Please open a scene in editor before injecting components."
			comp_status_label.modulate = Color(1.0, 0.3, 0.3)
		return

	var result: Dictionary = GodotComponentInjector.inject_component(comp_id, target_parent, undo_redo)
	if comp_status_label != null:
		if result.get("success", false):
			comp_status_label.text = "✔ " + String(result.get("message", ""))
			comp_status_label.modulate = Color(0.2, 0.9, 0.3)
		else:
			comp_status_label.text = "❌ " + String(result.get("message", ""))
			comp_status_label.modulate = Color(1.0, 0.3, 0.3)

# ==========================================
# 📚 TAB 3: SKILLS CATALOG
# ==========================================
func _setup_skills_tab() -> void:
	if skills_category_filter != null:
		skills_category_filter.clear()
		for cat: String in GodotSkillRegistry.CATEGORIES:
			skills_category_filter.add_item(cat)
		if not skills_category_filter.item_selected.is_connected(_on_category_selected):
			skills_category_filter.item_selected.connect(_on_category_selected)

	if skills_search_input != null and not skills_search_input.text_changed.is_connected(_on_skills_search_changed):
		skills_search_input.text_changed.connect(_on_skills_search_changed)

	_render_skills_list()

func _on_category_selected(_index: int) -> void:
	_render_skills_list()

func _on_skills_search_changed(_new_text: String) -> void:
	_render_skills_list()

func _render_skills_list() -> void:
	if skills_list_container == null:
		return

	for child in skills_list_container.get_children():
		child.queue_free()

	var selected_cat: String = "All Categories"
	if skills_category_filter != null and skills_category_filter.selected >= 0:
		selected_cat = skills_category_filter.get_item_text(skills_category_filter.selected)

	var search_query: String = skills_search_input.text.strip_edges().to_lower() if skills_search_input != null else ""
	var skills: Array[Dictionary] = GodotSkillRegistry.get_skills_by_category(selected_cat)

	for skill: Dictionary in skills:
		var title: String = String(skill.get("title", ""))
		var desc: String = String(skill.get("description", ""))
		var skill_id: String = String(skill.get("id", ""))
		var prompt_hint: String = String(skill.get("prompt_hint", ""))

		if not search_query.is_empty():
			if not title.to_lower().contains(search_query) and not desc.to_lower().contains(search_query) and not skill_id.contains(search_query):
				continue

		var panel: PanelContainer = PanelContainer.new()
		var vbox: VBoxContainer = VBoxContainer.new()

		var title_lbl: Label = Label.new()
		title_lbl.text = "⚡ " + title + " [" + String(skill.get("category", "")) + "]"
		title_lbl.add_theme_font_size_override("font_size", 13)

		var desc_lbl: Label = Label.new()
		desc_lbl.text = desc
		desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.modulate = Color(0.8, 0.8, 0.8, 1.0)

		var hbox_actions: HBoxContainer = HBoxContainer.new()
		var btn_copy_prompt: Button = Button.new()
		btn_copy_prompt.text = "📋 Copy AI Prompt"
		btn_copy_prompt.pressed.connect(_on_copy_text_pressed.bind(prompt_hint, btn_copy_prompt))

		var btn_copy_id: Button = Button.new()
		btn_copy_id.text = "Copy Skill ID (" + skill_id + ")"
		btn_copy_id.pressed.connect(_on_copy_text_pressed.bind(skill_id, btn_copy_id))

		hbox_actions.add_child(btn_copy_prompt)
		hbox_actions.add_child(btn_copy_id)

		vbox.add_child(title_lbl)
		vbox.add_child(desc_lbl)
		vbox.add_child(hbox_actions)
		panel.add_child(vbox)
		skills_list_container.add_child(panel)

# ==========================================
# 🩺 TAB 4: PROJECT DOCTOR
# ==========================================
func _setup_doctor_tab() -> void:
	if btn_run_doctor != null and not btn_run_doctor.pressed.is_connected(_on_run_doctor_pressed):
		btn_run_doctor.pressed.connect(_on_run_doctor_pressed)

	if doctor_results_tree != null:
		doctor_results_tree.columns = 4
		doctor_results_tree.set_column_title(0, "Severity")
		doctor_results_tree.set_column_title(1, "File")
		doctor_results_tree.set_column_title(2, "Line")
		doctor_results_tree.set_column_title(3, "Issue & Suggestion")
		doctor_results_tree.column_titles_visible = true

func _on_run_doctor_pressed() -> void:
	var report: Dictionary = GodotInEditorDoctor.run_audit("res://")
	
	if doctor_summary_label != null:
		var total: int = int(report.get("total_files", 0))
		var clean: int = int(report.get("clean_files", 0))
		var issues: int = int(report.get("issue_count", 0))

		var summary_text: String = "[b]Audit Results:[/b] Scanned [b]%d[/b] GDScript files.\n" % total
		if issues == 0:
			summary_text += "[color=#20df40][b]✔ 100%% Clean & Type-Safe![/b] All %d files passed with zero warnings.[/color]" % clean
		else:
			summary_text += "[color=#ffaa00][b]Found %d issues[/b] across %d files. %d files clean.[/color]" % [issues, total - clean, clean]
		doctor_summary_label.text = summary_text

	if doctor_results_tree != null:
		doctor_results_tree.clear()
		var root: TreeItem = doctor_results_tree.create_item()

		var issue_list: Array = report.get("issues", [])
		for iss in issue_list:
			var item: TreeItem = doctor_results_tree.create_item(root)
			var sev: String = String(iss.get("severity", "WARNING"))
			item.set_text(0, "❌ ERROR" if sev == "ERROR" else "⚠️ WARN")
			item.set_custom_color(0, Color(1.0, 0.3, 0.3) if sev == "ERROR" else Color(1.0, 0.7, 0.1))
			item.set_text(1, String(iss.get("file", "")))
			item.set_text(2, str(iss.get("line", 0)))
			item.set_text(3, String(iss.get("message", "")) + " -> " + String(iss.get("suggestion", "")))

# ==========================================
# 🌟 TAB 5: GODOT AWESOME HUB
# ==========================================
func _setup_awesome_tab() -> void:
	if awesome_category_option != null:
		awesome_category_option.clear()
		for cat: String in GodotAwesomeRegistry.AWESOME_CATEGORIES:
			awesome_category_option.add_item(cat)
		if not awesome_category_option.item_selected.is_connected(_on_awesome_category_selected):
			awesome_category_option.item_selected.connect(_on_awesome_category_selected)

	if awesome_search_input != null and not awesome_search_input.text_changed.is_connected(_on_awesome_search_changed):
		awesome_search_input.text_changed.connect(_on_awesome_search_changed)

	_render_awesome_list()

func _on_awesome_category_selected(_index: int) -> void:
	_render_awesome_list()

func _on_awesome_search_changed(_new_text: String) -> void:
	_render_awesome_list()

func _render_awesome_list() -> void:
	if awesome_list_container == null:
		return

	for child in awesome_list_container.get_children():
		child.queue_free()

	var selected_cat: String = "All Resources"
	if awesome_category_option != null and awesome_category_option.selected >= 0:
		selected_cat = awesome_category_option.get_item_text(awesome_category_option.selected)

	var query: String = awesome_search_input.text if awesome_search_input != null else ""
	var resources: Array[Dictionary] = GodotAwesomeRegistry.search_resources(query, selected_cat)

	for res: Dictionary in resources:
		var panel: PanelContainer = PanelContainer.new()
		var vbox: VBoxContainer = VBoxContainer.new()
		vbox.theme_override_constants.separation = 4

		# Title + Author line
		var title_lbl: Label = Label.new()
		title_lbl.text = "🌟 " + String(res.get("title", "")) + " (by " + String(res.get("author", "Community")) + ")"
		title_lbl.add_theme_font_size_override("font_size", 13)

		# Tags row
		var tags: Array = res.get("tags", [])
		var tags_text: String = "Tags: " + ", ".join(tags)
		var tags_lbl: Label = Label.new()
		tags_lbl.text = tags_text
		tags_lbl.add_theme_font_size_override("font_size", 10)
		tags_lbl.modulate = Color(0.4, 0.8, 1.0, 0.9)

		# Description
		var desc_lbl: Label = Label.new()
		desc_lbl.text = String(res.get("description", ""))
		desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.modulate = Color(0.85, 0.85, 0.85, 1.0)

		# Action buttons
		var hbox_actions: HBoxContainer = HBoxContainer.new()
		hbox_actions.theme_override_constants.separation = 6

		var url: String = String(res.get("url", ""))
		var ai_prompt: String = String(res.get("ai_prompt", ""))

		var btn_open: Button = Button.new()
		btn_open.text = "🌐 Open in Browser"
		btn_open.pressed.connect(GodotAwesomeRegistry.open_url.bind(url))

		var btn_copy_url: Button = Button.new()
		btn_copy_url.text = "📋 Copy Link"
		btn_copy_url.pressed.connect(_on_copy_text_pressed.bind(url, btn_copy_url))

		var btn_ask_ai: Button = Button.new()
		btn_ask_ai.text = "💡 Ask AI Prompt"
		btn_ask_ai.pressed.connect(_on_copy_text_pressed.bind(ai_prompt, btn_ask_ai))

		hbox_actions.add_child(btn_open)
		hbox_actions.add_child(btn_copy_url)
		hbox_actions.add_child(btn_ask_ai)

		vbox.add_child(title_lbl)
		vbox.add_child(tags_lbl)
		vbox.add_child(desc_lbl)
		vbox.add_child(hbox_actions)
		panel.add_child(vbox)
		awesome_list_container.add_child(panel)

# ==========================================
# 📋 CLIPBOARD HELPER
# ==========================================
func _on_copy_text_pressed(text: String, btn: Button) -> void:
	DisplayServer.clipboard_set(text)
	var old_text: String = btn.text
	btn.text = "✔ Copied!"
	await get_tree().create_timer(1.5).timeout
	if is_instance_valid(btn):
		btn.text = old_text
