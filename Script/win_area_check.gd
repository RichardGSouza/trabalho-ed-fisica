extends Area2D

@export var playerChecado: String
var playerNaArea: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var overlapping_bodies = get_overlapping_bodies()
	if overlapping_bodies.is_empty():
		playerNaArea = false
	else:
		for body in get_overlapping_bodies():
			if body.name == playerChecado:
				playerNaArea = true
			else:
				playerNaArea = false
