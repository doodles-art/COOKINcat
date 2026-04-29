extends Control

func on_PLAY_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Pantalla_Cultivo.tscn")

func on_OPTIONS_pressed():
	get_tree().change_scene_to_file("res://ESCENAS/Menu_Opciones.tscn")

func on_ExitGAME_pressed():
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
