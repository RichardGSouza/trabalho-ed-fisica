extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var forca_corda = Vector2.ZERO

var pulos: int = 0
const max_pulos: int = 2

@onready var spawn_point = get_node("../../SpawnPointP1")

func _ready() -> void:
	global_position = spawn_point.global_position

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		pulos = 0

	if Input.is_action_just_pressed("ui_up") and pulos < max_pulos:
		pulos += 1
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
