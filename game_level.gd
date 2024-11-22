extends Node2D
 
var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@export var host: Button
@export var join: Button
 
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
 
# this get called on the server and clients
func peer_connected(id):
	print("Player Connected " + str(id))
	
# this get called on the server and clients
func peer_disconnected(id):
	print("Player Disconnected " + str(id))
	GameManager.Players.erase(id)
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i.name == str(id):
			i.queue_free()
# called only from clients
func connected_to_server():
	print("connected To Sever!")
	SendPlayerInformation.rpc_id(1, "player", multiplayer.get_unique_id())


@rpc("any_peer")
func SendPlayerInformation(name, id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] ={
			"name" : name,
			"id" : id,
			"score": 0
		}
	
	if multiplayer.is_server():
		for i in GameManager.Players:
			SendPlayerInformation.rpc(GameManager.Players[i].name, i)
			
# called only from clients
func connection_failed():
	print("Couldnt Connect")
	
func _on_host_pressed():
	host.visible = false;
	join.visible = false;
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	SendPlayerInformation("host", multiplayer.get_unique_id())
	_add_player()

 
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)

 
func _on_join_pressed():
	host.visible = false;
	join.visible = false;
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
