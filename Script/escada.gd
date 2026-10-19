extends Area2D

func _ready() -> void:
	body_entered.connect(_ao_entrar_na_escada)
	body_exited.connect(_ao_sair_da_escada)

func _ao_entrar_na_escada(body: Node2D) -> void:
	if body.has_method("entrar_na_escada"):
		body.entrar_na_escada()

func _ao_sair_da_escada(body: Node2D) -> void:
	if body.has_method("sair_da_escada"):
		body.sair_da_escada()
