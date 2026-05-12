extends Area2D

#este area sirve para guiar al jugador hacia donde tiene que plantar en el huerto

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false #al cargar la escena que la forma no sea visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if BolsilloUi.isdragging : #si estamos arrastrando un objeto del inventario hacemos visible el area
		visible=true
	else:
		visible =false
