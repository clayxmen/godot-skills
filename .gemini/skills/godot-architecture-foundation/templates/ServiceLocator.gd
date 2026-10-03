# res://src/core/services/service_locator.gd
class_name ServiceLocator
extends RefCounted
## Enterprise Service Locator for Godot 4.x
## Decouples subsystems without relying on sprawling singletons.

static var _services: Dictionary[StringName, Object] = {}

## Registers a service instance under a unique StringName key.
static func register_service(service_name: StringName, instance: Object) -> void:
	assert(instance != null, "Cannot register null service instance for: %s" % service_name)
	if _services.has(service_name):
		push_warning("ServiceLocator: Overwriting existing service '%s'" % service_name)
	_services[service_name] = instance

## Unregisters a service by key.
static func unregister_service(service_name: StringName) -> void:
	_services.erase(service_name)

## Retrieves a registered service instance. Throws an assertion in debug builds if not found.
static func get_service(service_name: StringName) -> Object:
	assert(_services.has(service_name), "ServiceLocator: Service '%s' is not registered." % service_name)
	return _services.get(service_name)

## Safely checks if a service is registered without throwing errors.
static func has_service(service_name: StringName) -> bool:
	return _services.has(service_name)

## Clears all services. Ideal for game resets and integration testing.
static func clear_all() -> void:
	_services.clear()
