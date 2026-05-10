extends Control

func on_Orchard_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Pantalla_Cultivo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
