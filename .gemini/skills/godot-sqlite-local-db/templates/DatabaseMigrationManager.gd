# res://src/core/database/database_migration_manager.gd
class_name DatabaseMigrationManager
extends RefCounted
## Versioned SQL Schema Migration Runner for Godot 4.x

static func run_migrations(db: Object) -> bool:
	if db == null:
		return false

	db.query("CREATE TABLE IF NOT EXISTS __migrations (version INTEGER PRIMARY KEY, applied_at DATETIME DEFAULT CURRENT_TIMESTAMP);")
	db.query("SELECT MAX(version) as max_v FROM __migrations;")
	
	var current_version: int = 0
	if not db.query_result.is_empty() and db.query_result[0]["max_v"] != null:
		current_version = int(db.query_result[0]["max_v"])

	var migrations: Array[String] = [
		"""
		CREATE TABLE IF NOT EXISTS player_stats (
			id TEXT PRIMARY KEY,
			level INTEGER DEFAULT 1,
			exp INTEGER DEFAULT 0,
			gold INTEGER DEFAULT 0
		);
		CREATE TABLE IF NOT EXISTS item_records (
			instance_id TEXT PRIMARY KEY,
			item_id TEXT NOT NULL,
			quantity INTEGER DEFAULT 1,
			durability REAL DEFAULT 100.0
		);
		""",
		"""
		CREATE TABLE IF NOT EXISTS combat_logs (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			target_id TEXT NOT NULL,
			damage_dealt REAL NOT NULL,
			is_crit INTEGER DEFAULT 0,
			timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
		);
		"""
	]

	for i in range(current_version, migrations.size()):
		var next_version: int = i + 1
		db.query("BEGIN TRANSACTION;")
		var success: bool = db.query(migrations[i])
		if success:
			db.query("INSERT INTO __migrations (version) VALUES (%d);" % next_version)
			db.query("COMMIT;")
		else:
			db.query("ROLLBACK;")
			push_error("DatabaseMigration: Migration v%d failed." % next_version)
			return false

	return true
