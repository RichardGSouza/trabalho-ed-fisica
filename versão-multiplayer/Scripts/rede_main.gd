extends Node

@export var cena_jogador1: PackedScene
@export var cena_jogador2: PackedScene

@onready var jogadores: Node2D = $"../Jogadores"
@onready var spawner: MultiplayerSpawner = $"../MultiplayerSpawner"


func _ready() -> void:
	spawner.spawn_path = NodePath("../Jogadores")
	spawner.spawn_function = Callable(self, "_spawn_player")
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)
		spawner.spawn({"peer_id": 1})
		for peer_id in multiplayer.get_peers():
			spawner.spawn({"peer_id": peer_id})
	multiplayer.connected_to_server.connect(_ao_conectar)
	multiplayer.connection_failed.connect(_ao_falhar)
	multiplayer.server_disconnected.connect(_ao_desconectar)
	multiplayer.peer_disconnected.connect(_jogador_desconectado)

func _on_peer_connected(id: int):
	if multiplayer.is_server():
		spawner.spawn({"peer_id": id})

func _spawn_player(data: Variant) -> Node:
	var id: int = int(data["peer_id"])
	
	var jogador: Node
	if id == 1:
		jogador = cena_jogador1.instantiate()
	else:
		jogador = cena_jogador2.instantiate()

	jogador.name = str(id)
	jogador.set_multiplayer_authority(id)
	
	return jogador

func _ao_conectar():
	print("Conexão com o servidor estabelecida!")

func _ao_falhar():
	print("Não foi possível conectar ao servidor.")

func _ao_desconectar():
	get_tree().change_scene_to_file("res://Cenas/menu.tscn")
	print("Conexão com o servidor perdida.")

func _jogador_desconectado(id : int):
	if not multiplayer.is_server():
		return
	var personagem = jogadores.get_node_or_null(str(id))
	if personagem:
		personagem.queue_free()

	print("Jogador desconectado. ID: ", id)
