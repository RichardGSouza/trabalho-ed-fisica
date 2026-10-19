extends Node2D

@onready var player1 = get_node("../Player1")
@onready var player2 = get_node("../Player2")
@onready var linha = $Line2D

var conectada = false
var pode_conectar = false
var P1_puxando = false
var P2_puxando = false
const forca_maxima = 100
const forca_puxada = 50
const distancia_corda = 400


func _process(_delta: float) -> void:
	# Controle dos botões da corda
	P1_puxando = Input.is_action_pressed("P1 puxar corda")
	P2_puxando = Input.is_action_pressed("P2 puxar corda")

	# Mostrar a corda
	if conectada == false:
		linha.hide()
	else:
		linha.clear_points()
		linha.add_point(player1.global_position + Vector2(0, 40))
		linha.add_point(player2.global_position + Vector2(0, 40))
		linha.show()

	# Distância entre os jogadores
	var distance = player1.global_position.distance_to(player2.global_position)

	if distance <= 50:
		pode_conectar = true
	else:
		pode_conectar = false

	# Conectar e desconectar a corda
	if Input.is_action_just_pressed("conectar corda"):
		if conectada:
			conectada = false
			player1.forca_corda = Vector2.ZERO
			player2.forca_corda = Vector2.ZERO
		elif pode_conectar:
			conectada = true

	# Física da corda
	var direcao = (player2.global_position - player1.global_position).normalized()

	if conectada and distance > distancia_corda:
		player1.forca_corda = direcao * forca_maxima
		player2.forca_corda = -direcao * forca_maxima
	elif conectada and P1_puxando and distance > 60:
		player1.forca_corda = Vector2.ZERO
		player2.forca_corda = -direcao * forca_puxada
	elif conectada and P2_puxando and distance > 60:
		player1.forca_corda = direcao * forca_puxada
		player2.forca_corda = Vector2.ZERO
	else:
		player1.forca_corda = Vector2.ZERO
		player2.forca_corda = Vector2.ZERO
