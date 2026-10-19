extends Node2D

@export var proximoNivel: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_node("WinAreaP1").playerNaArea and get_node("WinAreaP2").playerNaArea:
		var next_level_path = "res://Cenas/Levels/" + proximoNivel + ".tscn"
		if ResourceLoader.exists(next_level_path):
			get_tree().change_scene_to_file(next_level_path)
		else:
			print("Erro. ", next_level_path, " Não exsite")
