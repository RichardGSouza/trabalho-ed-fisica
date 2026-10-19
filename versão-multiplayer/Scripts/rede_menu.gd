extends Node

const PORTA: int = 7000
const MAX_PLAYERS: int = 2

func criar_host():
	var peer = ENetMultiplayerPeer.new()
	
	var err = peer.create_server(PORTA, MAX_PLAYERS - 1)
	
	if err != OK:
		print("Erro ao criar o servidor: ", err)
		return
	
	multiplayer.multiplayer_peer = peer
	print("Servidor criado: ", peer)

func entrar_no_jogo(ip: String):
	var peer = ENetMultiplayerPeer.new()
	
	var err = peer.create_client(ip, PORTA)
	
	if err != OK:
		print("Erro ao iniciar conexão: ", err)
		return
	
	multiplayer.multiplayer_peer = peer
	print("Tentando conectar...")
