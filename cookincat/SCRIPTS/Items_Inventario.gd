extends Panel

@onready var icon: TextureRect =$icon

func _ready():
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE


#funcion llamada cuando haces click y empiezas a desplazar (devuelves los datos de lo que quieres mover)
func _get_drag_data(at_position: Vector2) -> Variant:
	
	#si no esta sobre ninguna textura(celda)
	if icon.texture == null:
		return
	 
	#cuando arrastras se muestra una preview del objeto al lado del raton
	var preview=icon.duplicate() #duplica la textura de la celda

	#para centrar la preview
	var c=Control.new()
	c.add_child(preview)
	preview.position-=Vector2(25,25)
	
	
	set_drag_preview(c) ##lo pone debajo del mouse mientras lo arrastras
	
	return icon
	
	
