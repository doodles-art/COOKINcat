extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Inventario: #si inventario existe (si no  hago esto da errores al escribir lo de abajo en el output)
		var wallet = json_handler.load_json_file("res://JSON_files/wallet_data.json")
		Inventario._sumarItem(1,2)
		sell(1)
		pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
