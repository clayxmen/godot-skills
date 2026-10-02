# res://src/core/services/save/save_manager.gd
class_name SaveManager
extends Node
## Encrypted Multi-Slot Save Manager Service for Godot 4.x

const SAVE_DIR: String = "user://saves/"
const ENCRYPTION_PASSPHRASE: String = "GD4_SECURE_SALT_99381A"

static func save_game(slot_index: int, payload: SaveDataPayload) -> bool:
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)

	var target_path: String = SAVE_DIR + "slot_%02d.dat" % slot_index
	var temp_path: String = SAVE_DIR + "slot_%02d.tmp" % slot_index

	var data_dict: Dictionary = payload.to_dict()
	var json_string: String = JSON.stringify(data_dict)

	var checksum: String = (json_string + ENCRYPTION_PASSPHRASE).sha256_text()
	var final_envelope: Dictionary = {
		"checksum": checksum,
		"data": data_dict
	}

	var file: FileAccess = FileAccess.open_encrypted_with_pass(temp_path, FileAccess.WRITE, ENCRYPTION_PASSPHRASE)
	if file == null:
		push_error("SaveManager: Failed to open temp save file for writing: %s" % temp_path)
		return false

	file.store_string(JSON.stringify(final_envelope))
	file.close()

	if FileAccess.file_exists(target_path):
		DirAccess.remove_absolute(target_path)
	var err: Error = DirAccess.rename_absolute(temp_path, target_path)

	return err == OK

static func load_game(slot_index: int) -> SaveDataPayload:
	var target_path: String = SAVE_DIR + "slot_%02d.dat" % slot_index
	if not FileAccess.file_exists(target_path):
		return null

	var file: FileAccess = FileAccess.open_encrypted_with_pass(target_path, FileAccess.READ, ENCRYPTION_PASSPHRASE)
	if file == null:
		push_error("SaveManager: Failed to decrypt save file: %s" % target_path)
		return null

	var content: String = file.get_as_text()
	file.close()

	var parse_result: Variant = JSON.parse_string(content)
	if not (parse_result is Dictionary):
		push_error("SaveManager: Corrupted save data envelope.")
		return null

	var envelope: Dictionary = parse_result as Dictionary
	var recorded_checksum: String = envelope.get("checksum", "")
	var data_dict: Dictionary = envelope.get("data", {})

	var expected_checksum: String = (JSON.stringify(data_dict) + ENCRYPTION_PASSPHRASE).sha256_text()
	if recorded_checksum != expected_checksum:
		push_error("SaveManager: Tamper detected! Checksum mismatch.")
		return null

	var payload: SaveDataPayload = SaveDataPayload.new()
	payload.from_dict(data_dict)
	return payload
