extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var corda = preload("res://Cenas/corda.tscn")
@onready var spawn_point = get_node("../../SpawnPointP2")

#especificações do dash
const DASH_DURATION = 0.3
const DASH_SPEED = 1000

#facing_direction, pra que direcao o jogador está olhando
var direcao_olhando = 0
var forca_corda = Vector2.ZERO

#controle da habilidade
var pode_dar_dash: bool = false
var dash_timer = 0.0

func resetarProSpawn() -> void:
	self.global_position = spawn_point.global_position

func morrer() -> void:
	resetarProSpawn()
	get_node("../1").resetarProSpawn()

func _ready() -> void:
	resetarProSpawn()
	var id = int(name)
	var cordaInstanciar: Node
	cordaInstanciar = corda.instantiate()
	
	cordaInstanciar.name = name
	cordaInstanciar.set_multiplayer_authority(id)

	get_parent().add_child(cordaInstanciar)

func checarColisaoEspinho() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if(collision.name == "SpikeLayer"):
			morrer()

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		pode_dar_dash = true

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")

	if Input.is_action_just_pressed("ui_accept") and pode_dar_dash:
			dash_timer = DASH_DURATION
			pode_dar_dash = false

	if dash_timer > 0.0:
		velocity.x = DASH_SPEED * direcao_olhando
		dash_timer -= delta
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0:
		direcao_olhando = direction

	velocity += forca_corda

	move_and_slide()
	checarColisaoEspinho()
