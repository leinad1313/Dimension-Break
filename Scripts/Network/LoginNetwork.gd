extends Node


func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", 3306)
	get_tree().set_network_peer(peer)
	
	

func _connected_fail():
	print("connection failed")


