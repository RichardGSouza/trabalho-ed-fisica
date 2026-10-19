extends CharacterBody2D

@onready var spawn_point = get_node("../SpawnP1")
@onready var sprite = $AnimatedSprite2D

const SPEED = 250
const GRAVITY = 1000
const JUMP_SPEED = -400
const MAXIMO_DE_PULOS = 2
const ESCADA_VELOCIDADE = 150
const COYOTE_TIME = 0.12
var pulos = 0
var coyote_timer = 0.0
var forca_corda = Vector2.ZERO
var na_escada = false
var direcao_olhando = 1

func entrar_na_escada() -> void:
	na_escada = true

func sair_da_escada() -> void:
	na_escada = false

func resetarProSpawn() -> void:
	na_escada = false
	if(spawn_point != null):
		global_position = spawn_point.global_position
	else:
		print("Spawn point invalido do P1!")

func morrer() -> void:
	resetarProSpawn()
	var player2 = get_node("../Player2")
	if player2 != null:
		player2.resetarProSpawn()
	else:
		print("Falha em achar Player 2")

func checarColisaoEspinho() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if(collision.name == "SpikeLayer"):
			morrer()

func atualizarAnimacao(direction: float) -> void:
	if direction != 0:
		direcao_olhando = direction
	sprite.flip_h = direcao_olhando < 0

	if not is_on_floor():
		if velocity.y < 0:
			if pulos >= MAXIMO_DE_PULOS:
				sprite.play("djump")
			else:
				sprite.play("jump")
		else:
			sprite.play("fall")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

func _ready() -> void:
	if(spawn_point != null):
		global_position = spawn_point.global_position
	else:
		print("Spawn point invalido do P1!")

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("P1 esquerda", "P1 direita")
	velocity.x = direction * SPEED

	if na_escada and Input.is_action_pressed("P1 pulo"):
		velocity.y = -ESCADA_VELOCIDADE
	elif is_on_floor():
		pulos = 0
		coyote_timer = COYOTE_TIME
	else: #not is_on_floor()
		coyote_timer = maxf(coyote_timer - delta, 0.0)
		if pulos == 0:
			pulos = 1
		velocity.y += GRAVITY * delta

	if not na_escada and Input.is_action_just_pressed("P1 pulo") and (coyote_timer > 0.0 or pulos < MAXIMO_DE_PULOS):
		pulos += 1
		velocity.y = JUMP_SPEED

	velocity += forca_corda

	move_and_slide()

	checarColisaoEspinho()
	atualizarAnimacao(direction)
