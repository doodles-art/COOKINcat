extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventario._sumarItem(1,10)
	Inventario._sumarItem(7,2)
	Inventario._sumarItem(7,2)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
