extends Control

@onready var rede = $"Rede"

func _on_host_pressed() -> void:
	rede.criar_host()
	get_tree().change_scene_to_file("res://Cenas/main.tscn")

func _on_join_pressed() -> void:
	var ip = get_ip()
	if ip == "":
		print("Não foi possivel encontrar o IP da rede")
		return
	rede.entrar_no_jogo(ip)
	get_tree().change_scene_to_file("res://Cenas/main.tscn")

func get_ip() -> String:
	var ips = IP.get_local_addresses()
	
	for ip in ips:
		if ip.count(".") == 3 and not ip.begins_with("127."):
			print(ip)
			return ip
	return ""
