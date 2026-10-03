# res://src/core/services/pcg/runtime_nav_mesh_baker.gd
class_name RuntimeNavMeshBaker
extends Node
## Runtime Asynchronous NavMesh / NavPolygon Baker for Godot 4.x

signal baking_completed()

@export var navigation_region_2d: NavigationRegion2D
@export var navigation_region_3d: NavigationRegion3D

func rebake_2d() -> void:
	if navigation_region_2d:
		navigation_region_2d.bake_navigation_polygon(true)
		baking_completed.emit()

func rebake_3d() -> void:
	if navigation_region_3d:
		navigation_region_3d.bake_navigation_mesh(true)
		baking_completed.emit()
