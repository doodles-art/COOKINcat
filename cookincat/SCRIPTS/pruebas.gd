extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventario._sumarItem(7,14)
	Inventario._sumarItem(9,5)
	Inventario._sumarItem(5,9)
	Inventario._sumarItem(1,3)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
