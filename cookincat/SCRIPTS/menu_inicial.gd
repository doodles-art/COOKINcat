extends Control

func _ready() -> void:
	pass # Replace with function body.
	
func on_PLAY_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Pantalla_Cultivo.tscn")

func on_OPTIONS_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Menu_Opciones.tscn")

func on_ExitGAME_pressed():
	get_tree().quit()

func _process(delta: float) -> void:
	pass
