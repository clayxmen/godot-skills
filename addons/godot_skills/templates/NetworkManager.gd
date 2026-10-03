# res://src/core/services/network/network_manager.gd
class_name NetworkManager
extends Node
## High-Level ENet Network Manager for Godot 4.x
## Handles Server Hosting, Client Connections, and Peer Lifecycle Events.

signal server_created()
signal server_connection_failed()
signal client_connected_to_server()
signal player_peer_joined(peer_id: int)
signal player_peer_left(peer_id: int)

const DEFAULT_PORT: int = 7777
const MAX_PLAYERS: int = 16

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func host_game(port: int = DEFAULT_PORT) -> Error:
	peer = ENetMultiplayerPeer.new()
	var err: Error = peer.create_server(port, MAX_PLAYERS)
	if err != OK:
		push_error("NetworkManager: Failed to create server on port %d (Error: %s)" % [port, err])
		return err

	multiplayer.multiplayer_peer = peer
	server_created.emit()
	return OK

func join_game(server_ip: String = "127.0.0.1", port: int = DEFAULT_PORT) -> Error:
	peer = ENetMultiplayerPeer.new()
	var err: Error = peer.create_client(server_ip, port)
	if err != OK:
		push_error("NetworkManager: Failed to connect to %s:%d" % [server_ip, port])
		return err

	multiplayer.multiplayer_peer = peer
	return OK

func disconnect_game() -> void:
	if peer:
		peer.close()
		multiplayer.multiplayer_peer = null

func _on_peer_connected(peer_id: int) -> void:
	player_peer_joined.emit(peer_id)

func _on_peer_disconnected(peer_id: int) -> void:
	player_peer_left.emit(peer_id)

func _on_connected_to_server() -> void:
	client_connected_to_server.emit()

func _on_connection_failed() -> void:
	server_connection_failed.emit()

func _on_server_disconnected() -> void:
	disconnect_game()
