# res://src/core/database/sqlite_database_service.gd
class_name SQLiteDatabaseService
extends Node
## SQLite Database Service Wrapper with Safe Query Methods for Godot 4.x

const DB_PATH: String = "user://game_database.db"

var _db: Object = null

func initialize_database() -> bool:
	if not ClassDB.class_exists("SQLite"):
		push_warning("SQLiteDatabaseService: SQLite GDExtension not detected.")
		return false

	_db = ClassDB.instantiate("SQLite")
	_db.path = DB_PATH
	_db.open_db()

	return DatabaseMigrationManager.run_migrations(_db)

func execute_query(query_string: String) -> Array[Dictionary]:
	if _db == null:
		return []

	_db.query(query_string)
	return _db.query_result as Array[Dictionary]
